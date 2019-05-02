Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E3C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46807206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jeL1TmN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfEBORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:17:09 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34125 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:17:08 -0400
Received: by mail-ed1-f50.google.com with SMTP id w35so607222edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UwUTSGK3kFDqh59G348P1VSE287YQFCPyBJWkFGT2g=;
        b=jeL1TmN+9S7rxFSCfW9V3bYCQ9XkkRpCSHGcvfnrOsvTSAjY73LFSt1bUiVgtgHJNq
         Tv0DbnVWNwa8ZjVzru05IQyRWy3S/5OEqtHtNfr/GR2TVOwOJqI+yAZuJXWBMCL2pG4f
         re8W5PiiN/831GI+qo4H8mGQodK+253IOfYP2SJv+auBn37OqlvdOokiv0/y9Xk/xMCg
         T+14TN7gujRPTIqhsFgKKnmV+jKUYGVd5KWX38nwgSzlaAx0CpwFF17YHopwjY1k7gtD
         MLtUmtFpfiEFPRQtO43++BKD+FVRV2u7zlgVjWl+zwgCdyeyyFCx6zLeHvXkzQcj824S
         TQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UwUTSGK3kFDqh59G348P1VSE287YQFCPyBJWkFGT2g=;
        b=a641cxa3s0xqq9IXaqludwVaVdVfzKIe+3W7zBK/yCi69m8G5hAy2UgtRLvqInH2P7
         hd88ShX5+MoGEKJ7REOf1XcjZHPbdNd6Gz/drgLMDisEGUa0XOTxTE7502kbQRbbaRAa
         oUX7m8g0MsZhKvrZUsqihhzHK0kEjthYiUJa5x71JKA8IOyd6XpQRyz/IsrNyzCF1F2S
         FcGLtkoWlbEZ7H/RPZgxqM7AFOH3p99IsGsS390zwMeaxF2ggxdK6rXEjQtwj9iW5sv+
         kvjJzEKicm+h6Ul98HZsqPjunXJIG7ltGrtIxRXdsdABhWrdiDHppSDNKyeZbyU0DZKk
         TGWQ==
X-Gm-Message-State: APjAAAWqrZ8xCBAJy/0yBGKJsPqGNQ9FswhuYD/2nOUmqGlxHF2ASN3J
        tG0lrktOsXf8jm2rOJaw6/MTYI2Rc13o63vU4F3/7g==
X-Google-Smtp-Source: APXvYqxfxStCJ1a5V9dI9KazHvlQKGkMxuucoOz7ty4S41uLly2rKv78x1mRLAhuezLjjjPUXOHuGcrzAp0ZhX1u2YU=
X-Received: by 2002:a05:6402:13cf:: with SMTP id a15mr2763367edx.70.1556806626879;
 Thu, 02 May 2019 07:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com> <9e15bf41-8e74-3a76-c7b9-9712b2d5290b@redhat.com>
In-Reply-To: <9e15bf41-8e74-3a76-c7b9-9712b2d5290b@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 10:16:56 -0400
Message-ID: <CA+CK2bCfCoU3JHz=81+=RNwo9M6n_zRbmPgx+DNmAnPYQRcjOA@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     David Hildenbrand <david@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Memory unplug bits
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>

Thank you David.

Pasha
