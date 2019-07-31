Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617C5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03920693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9IAc92n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfGaNIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:08:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34161 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfGaNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:08:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so31850642pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TL4ILmZRNuWApLUyD7oozpBzIfadu1ztye/qAKfEyi0=;
        b=o9IAc92njeRE7fMYm10keRWyiBayxHYufS5PRZxQt2XBoIkDRi6h2JhPjY+nYsDzrQ
         QierZP8IlVMrnVHJ7ICiHwRt3cq/CUuLAiSWcVzpOCKR5Yll7YEk0tKt0ji/26VwRwos
         tKl6+dtqaujF72tNFvN3GnOyzbeajXwPuvtVDmhBTi/bd2beTcpmCFs4zAuxI79/BP0W
         v32ftsYFvO/p31Y2xqVDjh3mNyme+qaOtImrIF3IA+tdYLPip7BckedTkXfm5RIlrvvk
         sCfP4T0N4MxS7lpS2qWJucdZGHokv3qiamLVoYNvjPOXGgNrbhN56bih1wEId2m13qRJ
         INRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TL4ILmZRNuWApLUyD7oozpBzIfadu1ztye/qAKfEyi0=;
        b=t/sisQ77MPYucrZTU4sU0lY8AfrvSWmV0ZT2PxBhCww0BsX4SXUj0Wt9c3bmMqXIUi
         yt75jYWY8r+QLclbUYE3qJfumXjhRP3jFuhjSQ/9KVjyL21VSEGGqWXS9Ff//8MdAzro
         45/UE/raHFhmZ02F5O9XthQXbIRMpxHYv1BQjb1djzvfZyfshJjavda53Rn8DxOAy0My
         d03bkFtC2W8cuWBhYUK7GMTt5j13gL35aAgpMd0BRsVCSRt6bSCgE3gcsaKy9LIhgEpx
         oUrSGU/+GAH57jz6s42kFPM2LTr3wSxwNVMTxXV+STizuhp6dgNgyrfnDsqGMpqjzKm6
         Da8w==
X-Gm-Message-State: APjAAAXqfVIeUzj5mU1SK86hDmCuA2XaQNbnM9192Cnkjf/Y4sazCRyy
        X8O1bExuCr/TSDiLtBnw7Hs=
X-Google-Smtp-Source: APXvYqzz3sUkeLWgRarJc/fH+UNg3fDFQHHkDZqU062Dvg7MYNOWCYBFqo0xzt2PpEioibHX1uChIQ==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr6100364pfi.105.1564578483761;
        Wed, 31 Jul 2019 06:08:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b136sm85270194pfb.73.2019.07.31.06.08.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 06:08:03 -0700 (PDT)
Date:   Wed, 31 Jul 2019 06:08:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCH v2 01/10] driver core: add dev_groups to all drivers
Message-ID: <20190731130800.GA147138@dtor-ws>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731124349.4474-2-gregkh@linuxfoundation.org>
 <s5h4l32s71l.wl-tiwai@suse.de>
 <20190731125104.GA6062@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731125104.GA6062@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:51:04PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2019 at 02:49:26PM +0200, Takashi Iwai wrote:
> > On Wed, 31 Jul 2019 14:43:40 +0200,
> > Greg Kroah-Hartman wrote:
> > > 
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > Add the ability for the driver core to create and remove a list of
> > > attribute groups automatically when the device is bound/unbound from a
> > > specific driver.
> > > 
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Missing sign-off from Dmitry?
> 
> He never provided it :(
> 
> Dmitry, can you please do so?  I forgot to include that in the cover
> leter...

Yeah, sorry, I thought what I sent was a draft to be used as you wish
with it; I did not expect to be put down as an author. Anyway,

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
