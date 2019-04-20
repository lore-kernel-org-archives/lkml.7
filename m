Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2CCC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895B208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH6qtt0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfDTH37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:29:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35464 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDTH37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:29:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so3545238plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0walm6P/6efwRjWHafui6XopYt2biYmefDXoU2XjRE=;
        b=KH6qtt0VpizwpZFptxDfqcSzA2segQb7TS6O9woGE5I+aei8vBn3sLh52rlSoazVuy
         OHUNEqDVtT76eMq/M18lNCI01w/JfipEksmpPUtvh7eFreeRBLhYTgHtWNR1FVEvyQNk
         V3/BHdfPfPHyZaaXWWOlvC9hlem31FOgsgYtmE3xMtuMmBR+vTC3302lknaLV5RuAgqo
         NdNE2V2Cpv/vX7g9hrbKSxgkh3aIZrEjkWGiOl1EN4SAU3xtZOeiKndtVknLUmikXXVe
         lJgEKFH2r9ZbOX/5Nmb7DZifcRH7qYxhEfTqbwABnQBBQKpfzhKpOWuol9ey6zeb0z9h
         pJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0walm6P/6efwRjWHafui6XopYt2biYmefDXoU2XjRE=;
        b=MPCdXx34uH62eWFkWLf8hqO22nrwA68dc6cIC6mzypcJv/zy+XRj0+CUd4Y0rq5HhV
         7dVFBC7514ChlUsNjA759OIzC4GIzdp4HM+5Y0YHIDMxhEdBdKWpeWJyuf3G9WhfLaIr
         TRizgjiAiXjJo7CjTM4rtQaRREcdqku6GDlMcx9pnD6cY5Etnu7Q0Mllju9sqOAmlO65
         sqC7ieYJWgXahrsrJiNUxLkqYC8r/kuhHuudAJeR4pJ7lCRY5oKCyLAPDtYuh+gq5pDN
         vrnICNJSSHcvlqperBhr1zOVpaTcGOjpTDnKd5MmNSYHuBVeHElNkFNQIWbnYoDS9jM5
         xiVA==
X-Gm-Message-State: APjAAAUUT+irCliYuzDu/X0YroPOe+WQxCk0GA9IRSXnx9aK/WqJoVXz
        ynPaCkzS0R43YmYo+3+SkeI=
X-Google-Smtp-Source: APXvYqx8WtwDlr62vGrC2txHOyb68rGmoHA3DCGoeTVnpAOYYSMuow453OJDTXCPlk0T+FwfRxuEXw==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr7850119plo.279.1555745398461;
        Sat, 20 Apr 2019 00:29:58 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id t13sm16299156pgo.14.2019.04.20.00.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 00:29:57 -0700 (PDT)
Date:   Sat, 20 Apr 2019 00:29:53 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190420072952.GA10408@Asurada>
References: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 07:23:59AM +0000, S.j. Wang wrote:
> > >       /* Validate input and output sample rates */
> > > -     for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
> > > -             if (inrate == supported_input_rate[in])
> > > +     for (in = 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> > > +             if (inrate == supported_asrc_rate[in])
> > >                       break;
> > 
> > Not sure if we still need it upon having hw_constraint. Maybe m2m needs it?

> Yes.

OK. Then we can leave it there. Thanks
