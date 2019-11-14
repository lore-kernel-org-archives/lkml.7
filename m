Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E35C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB02620748
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wzDdYVXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:35:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38459 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:35:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id z25so5394995oti.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNGw4TfqpfUCJ1fFVpttb7yfMciDUeoomP1skmq9jqo=;
        b=wzDdYVXqT4Ey6M67cJpE2V9RW05xslTchPTS/hgQLgzS1Adyn/SSVZe8h+/FV3+OEr
         52aw9+G2ykaRfJ+mRf/qS93DqP/b1+Z7BIrrOLGGb96L9dS13FR/cQ5cJs76bWWlrK6W
         fqNBszqmuQdRuM/2GYczu5lSzGyKaI9xXrl4V/ZNMXYZfWwpYAi0lOB/oV28HZ7TjStS
         Zqfj2Avr6iBAu3jFnq7z/TQ870HCPlT3y93YEl4aHjCjK+JNpENeUdIZtSkOrBX6im9e
         w+lAIM11QP6vdr3x7EMoEeyf6fIy5ZiIpMHQUXkqsZwsodfqmPUjwrQgkGmNxSc/hft5
         YFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNGw4TfqpfUCJ1fFVpttb7yfMciDUeoomP1skmq9jqo=;
        b=bf1eXHiiT2kvL8yUtnKigN9KuXcfuStQ0bkoLVZBPLShadMnVabCjN1SCmYR40EtjH
         jHtAgMW7jDj9QkCMZ6ENhwqRv4ctj97/B2XCEG9Mz+iIGLpcpm6kWwKzlt7ISseEPsid
         2s0nBgze+oV0IEenCN6tEGMqDA/QjPz4g48kEJ72fAoY9KovcTEsKi/9+LkKAmQO+vKT
         chCEEAA66kdACExV3ZH5EYz3gtZ0V8IEZ3Cb2uMm82wZy3Ehy1x1LXysbdjE3BlAeCpO
         G2uKAbkQCo7mJPilQYDvnBlBmyw9y8izF+s1SQl1bUFPBoEtGhZZmch6xQHZztk13U+N
         f8yQ==
X-Gm-Message-State: APjAAAWrzSIY/0R8Lj/DUe65FDy5K43Zyg+fQCdS7JG0SA5JIZvtFXw1
        FS6Jy/oN9gGRSAHNTPOQiMBX7vS22Skg7tDU3l0qMg==
X-Google-Smtp-Source: APXvYqwhlbMIqVoDMtemn28FjHxtHG8v5mkLAQT8X9GpCHUizz0JFqeybR7UBBP0zJO9mCY12klfr97VHx+i97m3uhU=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr7713217otb.126.1573749316381;
 Thu, 14 Nov 2019 08:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
In-Reply-To: <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Nov 2019 08:35:04 -0800
Message-ID: <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class Memory
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Linux MM <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some quick feedback on your intro concerns...

On Thu, Nov 14, 2019 at 5:41 AM Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>
> Hi Alastair,
>
> The patch is huge and could/should probably be split in smaller pieces

Yeah, it's a must. Split the minimum viable infrastructure by topic
and then follow on with per-feature topic patches.

> to ease the review. However, having sinned on that same topic in the
> past, I made a first pass anyway. I haven't covered everything but tried
> to focus on the general setup of the driver for now.
> Since the patch is very long, I'm writing all the comments in one chunk
> here instead of spreading them over a few thousand lines, where some
> would be easy to miss.
>
>
> Update MAINTAINERS for the new files
>
> Have you discussed with the directory owner if it's ok to split the
> driver over several files?

My thought is to establish drivers/opencapi/ and move this and the
existing drivers/misc/ocxl/ bits there.
