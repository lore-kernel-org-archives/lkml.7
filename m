Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A70C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1843520674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7eVHomv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKKNvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:51:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34542 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:51:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so14786179wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=izNeXsLo3977cjjoeFa+PfRnLFlgVVkBlxrUA54lBXw=;
        b=r7eVHomvCFzVgSqaPu00nXlvsu2CmwhRGSy/9iohJdDJnBVol4Z+rDZ7ZdiOUSHPbu
         sb90/axg4jjubaawE429G6djgMnsbeU3QMfxKqPZ5Xq98wAs2ruK3K8okUopoAeJ5QXU
         wCH+aBFH+PsJN8z7qTvhQlL8Ce3Vkpp4anXY9Yq1ywIxMBwppeGuKbHKHv+DrTr487he
         o00mIMeeDqkD72OThJggPoj69+Cyi/sJ03CRp2FieaQZnvh4bCEsiSoEfPXNM+Kbuevv
         tRXplBisRWKXLkp+Njtvtmw0k7U+vLOZR1lSsKjNHwDVyd5/4qEZzzHHNFK0qMGhdPL1
         CvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=izNeXsLo3977cjjoeFa+PfRnLFlgVVkBlxrUA54lBXw=;
        b=eI/T084VDm9CRFTz9sjUHZMWCGaEsCL2QoXcf9gZ4ZW++LzRSePdLu5XypmKz4UeKR
         VeLemuIs7mAeZ1tqId7JfXFqSYsYjFOenRFnpKMhp+4JeGVgcRN89wYQfy7jBOdjAehq
         v59q5hKqDQ9yaV2u866QunFHlRDtcNObcezgjEFPXwUKzRsA6aqq/1gclZ8/P/E6jNNT
         qhljfbl7MI1ziDYPcvPrtJJTMc7o9XvSazuSKhCCTX6aobi8aHrWN3sQy7epl9fq/oNM
         MsRNMeFnoIkvtsYUMIyE0cMQhu7jfKDYNNXIkHAh0lPHMOZoPI89WrMaDOO9xVEcWsJb
         dXhg==
X-Gm-Message-State: APjAAAVrFx9j6ikzzyWhhuZBcmk4IdP4LGO9UAa3GypfzqEG9DECTSXQ
        pNMdue1PqcAREisgdOs8GCgZCu44WZNC
X-Google-Smtp-Source: APXvYqxCQFT7SyzScJu8SHd3WkubL0M0n53zH1agqu9W+57Nbeeq21fbjboyYJHzMYczlKpnjcSMMA==
X-Received: by 2002:adf:f44a:: with SMTP id f10mr5537827wrp.63.1573480304688;
        Mon, 11 Nov 2019 05:51:44 -0800 (PST)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.gmail.com with ESMTPSA id a7sm16513703wrr.89.2019.11.11.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:51:44 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Mon, 11 Nov 2019 13:51:33 +0000 (GMT)
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Jules Irenge <jbi.octave@gmail.com>, gregkh@linuxfoundation.org,
        jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Boqun.Feng@microsoft.com
Subject: Re: [PATCH] staging: wfx: add gcc extension __force cast
In-Reply-To: <20191109091913.GV26530@ZenIV.linux.org.uk>
Message-ID: <alpine.LFD.2.21.1911111347380.226731@ninjahub.org>
References: <20191108233837.33378-1-jbi.octave@gmail.com> <20191109091913.GV26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Nov 2019, Al Viro wrote:

> On Fri, Nov 08, 2019 at 11:38:37PM +0000, Jules Irenge wrote:
> > Add gcc extension __force and __le32 cast to fix warning issued by Sparse tool."warning: cast to restricted __le32"
> >
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  drivers/staging/wfx/debug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
> > index 0a9ca109039c..aa7b2dd691b9 100644
> > --- a/drivers/staging/wfx/debug.c
> > +++ b/drivers/staging/wfx/debug.c
> > @@ -72,7 +72,7 @@ static int wfx_counters_show(struct seq_file *seq, void *v)
> >  		return -EIO;
> >  
> >  #define PUT_COUNTER(name) \
> > -	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu(counters.count_##name))
> > +	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu((__force __le32)(counters.count_##name)))
> 
> NAK.  force-cast (and it's not a gcc extension, BTW - it's sparse) is basically
> "I know better; the code is right, so STFU already".  *IF* counters.count_...
> is really little-endian 32bit, then why isn't it declared that way?  And if
> it's host-endian, you've just papered over a real bug here.
> 
> As a general rule "fix" doesn't mean "tell it to shut up"...
> 

Thanks for the comments, I have updated  but I have a mixed mind on the 
__le32. I have to read more about it. 

I would appreciate if you can comment again on the update.
