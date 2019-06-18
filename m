Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1BC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61142070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDTAByqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfFRKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:30:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35936 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:30:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so14599060qtl.3;
        Tue, 18 Jun 2019 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wtQ3H/RqcO/beRnWTkfjA8r0vVjyM6yxlkekBWvD7LM=;
        b=GDTAByqqryYew57KnXrF6BB4jcZDHDJSYOH0Liw4w2FuBWdi9jPUufwFQbY5yW3CSL
         xbpl21kkDHBd3ZpnOE3L8z/koeG/Ch3X9/CFxOMH+m8Z46N1QWFSGVI/Lh1nvWHWECOy
         n7/j8311G2axMLG+Y2eTVId5/iYM/ZDji3s8YWwL3Ps0sZHC/7n9L58Hl5F+vy8UQy16
         2qr0qjR0LgSkFZuOC63cHGW3mad9lhxwnTRR28mrVT3wxHf9k3RkbdhMoICrHzQYh2cU
         j1YncGZfnq1fW3J1/sAc1kN8xy25XIjV8J1y/4KBi4gC8ex0GObUmgnc3PjUjzyW5NQQ
         vJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtQ3H/RqcO/beRnWTkfjA8r0vVjyM6yxlkekBWvD7LM=;
        b=o7OXbG7Xd+0X9Cg8UVqPupHyJRtByxHz6BAKjQ2NLfhfnieq3nH2xaaSoaY5xDE9+U
         qc5AR2zzLbpjCiHZqux9C9i6eqMQdYjE4dZorWahl+akyomUwhDWCdGoCKfPT3o62u4P
         MbknZjaPPTjrKk+wSbZShlxxqPosqPbx3opQfJzAZK9Oshs940YAY5XuMCjfKdodds+L
         4inK6PbcSXPGoPEr6P0xkI3ZiHHTHjpof4RhhudA+IwXAOiORCFSLvYulVgjIrpM+YT7
         NjURCw7QcxlQo/uFyB0IbBez1ktj7QKwkoEOnQ1VBK8olLWDPwJshml6DBiTYsmQ+Dsr
         NZTg==
X-Gm-Message-State: APjAAAWk1gENcrCYFmRyVAOKU2bInoODHnvzil4yKsZqUTV5pr/6TPzW
        DKtJIiVFm6Yr6+9HA7cFShxv+/pQzg4=
X-Google-Smtp-Source: APXvYqxfmZ10id4CdcAHra7m9KtxjeyGAqoO+t/QgcAFgYk5fWTCphfe/nyulxHSUuKuthplCU0EyA==
X-Received: by 2002:a0c:df8a:: with SMTP id w10mr15422264qvl.140.1560853819843;
        Tue, 18 Jun 2019 03:30:19 -0700 (PDT)
Received: from geeko ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id z126sm8586992qkb.7.2019.06.18.03.30.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 03:30:18 -0700 (PDT)
Date:   Tue, 18 Jun 2019 07:30:04 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618103001.GA9372@geeko>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-3-marcos.souza.org@gmail.com>
 <20190618064947.GB22457@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618064947.GB22457@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:49:47AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 17, 2019 at 10:31:46PM -0300, Marcos Paulo de Souza wrote:
> > If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> > be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> > 
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> >  drivers/usb/storage/scsiglue.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Where is patch 1/2 of this series?

You can find it here:
https://lore.kernel.org/lkml/20190618013146.21961-2-marcos.souza.org@gmail.com/

> 
> confused,
> 
> greg k-h

-- 
Thanks,
Marcos
