Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EBC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58B20656
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twB5Bu5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGEOsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:48:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfGEOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:48:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so4419297pgz.5;
        Fri, 05 Jul 2019 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4B5XvbAIoIr4H/nccPHJhvJByPo3v2+X8sDst0stIaA=;
        b=twB5Bu5LO0iS+ky5NCg0mWCJiC3Nz1bV4XCTBsB79dGmIJZITDLuE9L+iXCCEf4DOl
         AMTRuQZiVFfuZnfTfzV0MsmxhoFacoA5gkjtIKDOReKMaGjNhULybaAtDGSTeO9GQw3C
         pTHDV50xThG7Rg3ek7al7Bc2bwa35e8WwS1RurmAcvg11SPQG0e9Cxbu1qtoohtEvbZE
         En8i/IP7XsYdxEOHuRTw9IcqhOAfpbXeLyFLv8W+cnPxq7K7OEFRBDgr3JdauVFSr1kV
         EL4+Zd0f3Tk6XjdzHRPrr1znCUVljNZ8MZzyFDeUicAUPgLwxBRbuzcClTlvNmL70C01
         PlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4B5XvbAIoIr4H/nccPHJhvJByPo3v2+X8sDst0stIaA=;
        b=hXxsTN/JnFlKR3b7JUxiXQz2XnwJJwnloou1c+E05DHg7MecFQL38B7FT/TZ/OzDLd
         yM+aX5b9h6tvy9qKFtDVj3LYwE/7H++oo67AJrfvwRjgSEaA0PcMpQ5oMGFHSrTHUylr
         tCnpJ/igcoHv1tukqBynZei29LOO7JOO16OqQTTbxAJ2o6C+ntaQqijmoDp1S151FsQz
         7g6DNUteqo0IYDY8eZroXmBRtbfsvFhAKGBu67N4XlqeHnxW9jh1lkZKHMJ8kog3oR6p
         8LvWXOp/ibymk+43M5gGyodtrjz1kpo6teeibgf6xaokgSONQSJc3fqYI845hWZx2cc2
         04dQ==
X-Gm-Message-State: APjAAAVNkVEYvNrRpEjUQ97Kx1kPJLfxTWT3jOmwXlLvOqaPfJ8q87xf
        aRWQQhejTAHVVUPASd2w3DA6VgroCCho+B4rETE=
X-Google-Smtp-Source: APXvYqxUVOVt1xiMlerzjvYodulQOj61CTpzagtzy+7JthX+YBBFX6YrqZtz44pzkgCN5N+nBRLQcTTs5XMlRa+1pc0=
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr5952998pjh.40.1562338104173;
 Fri, 05 Jul 2019 07:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190704153529.9429-1-ryan5544@gmail.com> <20190704153529.9429-2-ryan5544@gmail.com>
 <20190705052208.GE15821@kroah.com>
In-Reply-To: <20190705052208.GE15821@kroah.com>
From:   Ryan Kennedy <ryan5544@gmail.com>
Date:   Fri, 5 Jul 2019 10:48:13 -0400
Message-ID: <CAJRN7XN0rKVsLtfOTeEt7JN69pdOtPkV31iAnN3fLiyYtejcQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: pci-quirks: Correct AMD PLL quirk detection
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 1:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 04, 2019 at 11:35:28AM -0400, Ryan Kennedy wrote:
> > The AMD PLL USB quirk is incorrectly enabled on newer Ryzen
> > chipsets. The logic in usb_amd_find_chipset_info currently checks
> > for unaffected chipsets rather than affected ones. This broke
> > once a new chipset was added in e788787ef. It makes more sense
> > to reverse the logic so it won't need to be updated as new
> > chipsets are added. Note that the core of the workaround in
> > usb_amd_quirk_pll does correctly check the chipset.
> >
> > Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
> > ---
> >  drivers/usb/host/pci-quirks.c | 31 +++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
>
> Should this be backported to stable kernels?

The bug is fairly harmless, so I wouldn't say it's a must-have. I only
noticed this because I saw the log message and was curious what the
quirk was for. The fix saves us calling usb_amd_quirk_pll() and taking
the lock in there. Others here should know better than I what's stable
worthy.

Ryan

>
> thanks,
>
> greg k-h
