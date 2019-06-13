Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14F32080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560466310;
	bh=n2JPnpMFvVz/zObPrcIQ6tVi3WhDItg6vVe8mpvVQs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pzw+lRSEt6Y0t+0RV3gM7Uj4C4fJMR24OYd18i8l476VWHsjPbVDzeV5TJFC4SrX7
	 WE/kEx6U/+qhDso/zCzVLGPl/B2THbTMGMkfXAyPCNy6U5uG9k2cpj0SW077uyOSr5
	 0DW9qHOZyWLN2cFRqG1V/ZbEGBTuM9wNYyI4qpTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfFMWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:51:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37907 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:51:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so361842qtl.5;
        Thu, 13 Jun 2019 15:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1jLdvJZozzrqHX1esdeObu7Bz6wiJlvCPsfxGMitgE=;
        b=Y25+fIIais/Ok5j4xJJggmm5FxRAcpzdRx2EPpShOXZfTD/bg+Dl3KvcgDOWBPBt3v
         LZWOpdvouTzYjJAmFhjMAGPgUQQ9rr6naEFGyVZyz2bJarUZFLq6ypShWpTyVPmh9343
         BHG/SijEsic9bwdVim6O5mwybc3pfesu3wCMU9D7dKPfOsCThPVXLE2MKD9FxuJVTJk8
         YuGf6CWTUDqU9IqdTQPXR+2GgSGJ98gdubghmL26LJ7HB20+gpwAl9qdzUQFnB00YWCz
         QEG7/3/+YTUSH5vLN+pd/GjMCCND3qX4qp/2dbkTHRs3HlB03E1ZcnZjJcXY12eDRLH9
         t9Ng==
X-Gm-Message-State: APjAAAW1cbap0FJIkQHxjFAxo73pFs8IWd90+Y1Z4J1rahv+3vtoSnlK
        ExCHX6kFj/8g0woz80Or8g==
X-Google-Smtp-Source: APXvYqzem4zi3kuCmkw6IRou/aoStUJUuSg911SowZ5Ya3+lMo/6NDr6HMK6vxTNwt20ngySVoIIkw==
X-Received: by 2002:ac8:3345:: with SMTP id u5mr79299891qta.219.1560466307557;
        Thu, 13 Jun 2019 15:51:47 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id g53sm548681qtk.65.2019.06.13.15.51.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:51:47 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:51:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength
 and nand-ecc-step-size optional
Message-ID: <20190613225146.GA17725@bogus>
References: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 14:29:54 -0400, Kamal Dasu wrote:
> nand-ecc-strength and nand-ecc-step-size can be made optional as
> brcmanand driver can support using the nand_base driver detected
> values.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
