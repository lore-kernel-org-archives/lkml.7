Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08754C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD67D22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UYQHthzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfH2WqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:46:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37507 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfH2Wp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:45:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id 97so2245233otr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIuig4xjj1okPm1v+nckMKBMxCFTk/w+YVlFEyiN+6I=;
        b=UYQHthzH50nn10Fq77yoEj2YvcrNXNY6o18RXam9bIfpl1wHeEULO4yuuCSRI/Ru2K
         RLreXb965cYq9f3IqoESXN6C24GqPvA0ZrmEimO02Cts4PIULu8eTSRXN1IJsCJpfuRT
         +BxwrrliSYijoXLFR2JXb4Dd9dixmo7nx0t/SCzsYhC6j9bvK86j3oNNTrtP+EVJSHkr
         99Pi3kPcsOf6m/wOqSI9Rwe2C2ZMhHPCJ4mFEsr7TfAmthneIydvqyFqOfcrDZTd1ej9
         rYDVYNrMO2OaS4qmIqAoNyXXvTyMb6cGBOK+FkHL6xZJdSGVe9V9M57hTVctnR+W3nW/
         RkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIuig4xjj1okPm1v+nckMKBMxCFTk/w+YVlFEyiN+6I=;
        b=YMmXAa0JFW51anrQpkTOaz955Rahb7SayNVTB7EMhZSz8qeou0mUZ8S4OtqbX2zgh8
         QFgmJyBFWNbCT16gEHlWHrB4R10L4GIy9iXjXCZQld7aicEbA38o43WUons+1ipcFZ3a
         SryA8IAu70DK1jEAZoIqDXhcItY21g8o/GY0vQxbKwCD8lqJkv7QnCCjDnE1XFEOH3G2
         ZM+1upL06RZ8L49ckWgY+Rzh38mF+uLEuJsAZvtwRZuo3rlYR8qNW6Y6uIbeHaJyY1qc
         5NtZBau7YljfGPECsW/W1b46T6f1bFmTyQnD6ecaKPDg2AhzqSESTnjax+lBO2bkjOyi
         7mHQ==
X-Gm-Message-State: APjAAAVZ6NMkGxvlz4RCugola3oqMG9gl/mLzxWdRROdlNCYmvuw87kA
        P624fIHp6HRiTC9xQtH3Pfba5kdauFBdz6EUqRYocw==
X-Google-Smtp-Source: APXvYqy2RByDJRCk/msHyU5rudzz0l2j2S1qCHXaP4lkineatCLBMlR9sdECn9SSUKEhV7aUFLo14KwjqemHdp5tUtA=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr9281786otr.247.1567118758900;
 Thu, 29 Aug 2019 15:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190830080855.45421fa0@canb.auug.org.au>
In-Reply-To: <20190830080855.45421fa0@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Aug 2019 15:45:48 -0700
Message-ID: <CAPcyv4iWUa-HVoODtbj-G2jxS0Tm-x_=s4PNQ-M-FvDibYFgFw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the nvdimm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   dcbce3cd20be ("libnvdimm/pfn: Fix namespace creation on misaligned addresses")
>
> Fixes tag
>
>   Fixes: commit a3619190d62e ("libnvdimm/pfn: stop padding pmem namespaces ...")
>
> has these problem(s):
>
>   - leading word 'commit' unexpected

"Fixes" fixed, thanks Stephen.
