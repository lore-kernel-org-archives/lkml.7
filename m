Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C840CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F64320854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+0tnqUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDJE3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:29:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44990 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfDJE3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:29:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so608443pfm.11;
        Tue, 09 Apr 2019 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdZvdqQbly2GoV2VZDP1pA/PSw3bIDCmLQVWa6Yk5Gk=;
        b=R+0tnqUsekcm2vwKrlIEpRE2SVXQg6xzizRoIy7QYlwO0Oo8GP9airmKXyeZUllEic
         LpCe5O1ph5QZmThq4R5kNa4Ep0m5J9xaDj+215CdmBpVHzK5h9DbOzd4Z+3hKvYJm1pq
         UAoGcaO7IyPsPv6tss0qwzR9JrA8JSGjpiGVvBMJElv1m/GKjICeN0hTHUeHY6LGe/EQ
         yxP5CzVt84vwZeNbuZKmSRh1+BnazcgmgaBDn0YzixUpsLb6gfHLlQ+0xScVzbiaEyF4
         BbLqb2NF2vwBeiCLJXVo1S0h7goNJS4EN1DKgjTlTpgwWYOm7ayl0DHxFMj2TAED1dEE
         hWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdZvdqQbly2GoV2VZDP1pA/PSw3bIDCmLQVWa6Yk5Gk=;
        b=WKzr539d8SAs8KRkDaHU01L1++SlAWTWQVa3wJqsuSJjYeNHt/bh1iIWY/6tLD8am7
         33iF+RaIjkdqyZnSoW+ZcEqgTU9Aq39ywVTfb1zxW4kbl2r+n4M8R3cF0nn0tqX0NfdX
         0AmPa/CcpE/eiqiMEt2u6XAcIQByW61aJET3zyPWZkdw5IaR+cPEn94++fR15ySsGjnI
         AfRWddDPxJYm2ppHJn55FrYgN0JbylgJJUjjdzLO/RZfmMSwaX4MlIB/wnd9LauBfvHK
         uOM9OiBDf/AmYDq0q4RWM0FZDLussXhZaeBd+gflNKAbwpjhB+gpRjkDo5fEO0j+tirx
         zC7w==
X-Gm-Message-State: APjAAAU9d+rgLPc97UphkrJ7b/4aIDVz5lUOydMp9PahNYPRsy4hl94o
        msfuW+B1Aka4fESaxRHPbRc=
X-Google-Smtp-Source: APXvYqytZvgU6i31AKx4F+iaDTgAuy3kkHWv5rZ5/XHnUekJxP8fZTGRhfIo8NZZiULekhMlWhp0qA==
X-Received: by 2002:a65:6105:: with SMTP id z5mr39437569pgu.378.1554870590961;
        Tue, 09 Apr 2019 21:29:50 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id s21sm12520228pfm.3.2019.04.09.21.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:29:50 -0700 (PDT)
Date:   Tue, 9 Apr 2019 21:29:47 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: fsl,audmix: remove "model" attribute
Message-ID: <20190410042946.GD3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554809242-27475-3-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:27:40AM +0000, Viorel Suman wrote:
> Remove "model" attribute.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
