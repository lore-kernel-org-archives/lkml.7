Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16948C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBAC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557768420;
	bh=syQ44fnnD7y73TTZnSqkO2xIptWs1Bn6WGSQ8RHs46w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l2tBw0tU+/J8Xt7jkELCAhGB7oAtJP+2E7ZE6o85O+nhI8w158mApy8OzMSLtpFgh
	 EoUdXCf76o/BslsnP34fK1kFmGWP/xCoqFlFd/uNMOtOdirJhZyyfPTPQSy4LM2X6v
	 t0TwYKDfw5wbSs6wz9UsVgXApPuvJbm+ToTH8xTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfEMR1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:27:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34983 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbfEMR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:26:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so5601647otk.2;
        Mon, 13 May 2019 10:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKIMabYolh/CWr9ZVS4BaOdQjFc8s0quPHe3Wg+vCIE=;
        b=LG04bSMY0kJGmMiM1c40anvUp3JNMunQX/rEWHtSAetVf7ieIPN7pBoXeTugY7rzwR
         UO8qDoZGbkgSic56d4oIU8rWLFD2QsWfvcnxlcUU3597W2GmvmunO7GCzXpPWiR2Q05h
         E2L0FPZzAFZUKOItk5S9fpindkGQhu8wxvnS2n7v4nuXd9H9IkjN6i7ssKYndbm8gZ1x
         HN4zqGe5dE3zlCRQ5ac3fWMr/b8tLk+yi3sns81E5pKtDdoFmy4f2u9Y8ANiCuGkJp5T
         BJLMStIV9s0stTZvzgwL8GOqHJFkasCf9hyCdTD0OOumXHtmkg4BnMKBUwjr557UK7sI
         FiRg==
X-Gm-Message-State: APjAAAV7IvpvPtcy1Yv/FixeQ6y/nemUXTAvcsExLiOZ8MpLO/QYXRHm
        URVdlebkTtqRFEwSLTV+FA==
X-Google-Smtp-Source: APXvYqxyXc8m8ojecJr8JAPWWliXRCzCTj/jyi66UThIvubAV42LSZvfB+YZ9RO6ckrbWofzjD016Q==
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr16867947otq.197.1557768417211;
        Mon, 13 May 2019 10:26:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y129sm5567619oig.27.2019.05.13.10.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:26:56 -0700 (PDT)
Date:   Mon, 13 May 2019 12:26:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 08/14] dt-bindings: spi: imx: add new i.mx6ul
 compatible  name
Message-ID: <20190513172655.GA12061@bogus>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 09:16:25 +0000, Robin Gong wrote:
> ERR009165 fixed from i.mx6ul, add its compatible name.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
