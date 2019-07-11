Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C7C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0A921537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtzST0TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfGKPqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:46:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46382 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfGKPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:46:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so3846571qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v4KYgyH/4ljAz+4kIqJ5UbIlgT4PyHXwUqWAr65W0AE=;
        b=LtzST0TSfHaTSN8EKfA5rzLP9CMF+CSchyU1aVHqzbdFceyuVLFjRIjR9/gC2DqPsL
         Z0jTon0n9ufm2c7Mw23ZziZ+u3JqJm4mQUvtuWtnm4J7XWIpezFEzkzYxhaII3N7D8av
         zeWF1jgpUJVFx/dk9qdO7JRN+LlXQ/q7kXjqyZi1h6CcgggpgQ+H+6xeYkaV2Q+ewoHL
         +Xzbg1ut9pkNSafeNh1qbwUClHWyoWsyo/ipCNL6rEHLBhD/251IMjrIGjbDSV4JKjD7
         /5PmZZTRgvtP+U55AhOAT8U6bMfr+j5GyKK2b+JUjBPmqlrjqA82EE52AFLE5yydkg+8
         u2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v4KYgyH/4ljAz+4kIqJ5UbIlgT4PyHXwUqWAr65W0AE=;
        b=IPuPA4yzbFe138gEpOhNbTyY/+iW4gepN6QBNZWr2rhLhYJZNtAncL6GnB7LtgMsTA
         0sTirVIuOpQ6ssu2przEyc280wHM8eHdsj1OxogI+11o60GoIQEsoGR8dJRqs352jKY+
         erGl1bDMuthew3b7ucDiyKAQ8RpkAEKZ4VpF+DIG0s8oKWyMvWFUn3gFPjkN5b3zcKg+
         rCAIVbXWAlWE269XSg/Bg8EzZGOqn6QckMR5aZIkY/pReVWlSUcUCzInSZeISh5vzf1O
         4jLzvwBkHu+ha5O0i65v6ZzW3GcNedj6Fu1Pc9cI/FULNBmWNWrC0EdetY6N26M6NeMX
         4Zjw==
X-Gm-Message-State: APjAAAVlMPCUq0wusyI4/gvEMOjpe0Zp5kYaVA76d0j6rvWfD+NXPEbz
        KzsEnfMOCnx3A0sKaysgVgI=
X-Google-Smtp-Source: APXvYqzwafVSw8ta8GT29K6dDZIOsYn06CbRIZ4tI1D2Hbl00y5oD+zEJauZLJQNsOmixADprP8jLA==
X-Received: by 2002:ac8:4996:: with SMTP id f22mr2347077qtq.142.1562859970381;
        Thu, 11 Jul 2019 08:46:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id c40sm2806047qtd.14.2019.07.11.08.46.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:46:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F20CD40340; Thu, 11 Jul 2019 12:46:06 -0300 (-03)
Date:   Thu, 11 Jul 2019 12:46:06 -0300
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, arnaldo.melo@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] minor fixes for perf cs-etm
Message-ID: <20190711154606.GA10090@kernel.org>
References: <20190321023122.21332-1-yuehaibing@huawei.com>
 <b5d842f9-3475-2560-2933-9a1984c1641a@huawei.com>
 <d178fc8c-7e6c-0272-4ead-9b4ee15d1e7d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d178fc8c-7e6c-0272-4ead-9b4ee15d1e7d@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 11, 2019 at 10:33:09PM +0800, Yuehaibing escreveu:
> 
> Arnaldo, can you pick this?
 

Thanks, and sorry for the delay, fell thru the cracks.

- Arnaldo
