Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8B3218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD9QT3wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfC2TsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:48:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45500 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfC2TsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:48:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so2970932ljd.12;
        Fri, 29 Mar 2019 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3pG+J+6pm8soWtrcGWPf9mBg2VNzd/Fy5QrHExC9ag=;
        b=nD9QT3wJaG6eqfuGtHKibKV42cf0wKvbkMChc5xwTgU+d+KUBEr2aAyxZSVls0ffYR
         tOuHnHIQUcqs3QxnPqgvYos/D6WJwn1CHpNETRtwOdp9p7fyhdPek64Pw2uccE7fxOs7
         x0gz6wzGIKgLnhV7YlDm+qDxdyTgMCPMDdXdT80YxSWv5QlgL6ow/m8yS77Ck6nu7EX7
         E7qXn3p/ckUu4kVhm81YL4MIqS7lLCGA/nGgtLWdQENpkWqW0aFrZOymslSAXzEqCChn
         0UhhXQwFW1Ne19IDE8Ofrkm/vQrZJRoAB49/CsE+w6wpYdMsRF1KbkODs+lnTOnDB1zn
         yOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3pG+J+6pm8soWtrcGWPf9mBg2VNzd/Fy5QrHExC9ag=;
        b=ImZMjqd3WkO/UZDwahEOw0CZ5rL53PqMI4J40jufH94Qs+653wbq4DV/wtPlGK42QD
         S6PooA5zbWg7CMsa2OyFAwgT3AuR2u+EImvFyb0NrhJptVdcciQhJVxoB2H0teZjnHcL
         xUQXlBBFnpO+ml9d/9I96NwZk0xiVVpMBTsY55gxrbFSo+8jxUVYSv8Fl3h+2+BveSKE
         mvxcKzeHV8ymiff0ciqTaxI9Y+aSjmRbGk9Ygi1g4IUPKJKpXy88L4/stJZrunqfY6e8
         rIAbYDkP1hsrHfZuwl9ur1XnSE46IE6H+hj4RUl1ZtTul4keIDE6fRipA+5yhWgkWJbj
         r30w==
X-Gm-Message-State: APjAAAVXeEsgP/mB3tPOKWHUmU4fbDN2WtN3Q9n9Ov5GORUBvORuXjlI
        WcKQn1eVtrfbKNCl+esWQio=
X-Google-Smtp-Source: APXvYqzF/2fOwI6KQOSTMY8fNrPkMIAmgjG2VRlj5lalIiB+rE3uCWTq5udPn2xbkHnS7O2UBscrAw==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr19604532ljg.197.1553888902200;
        Fri, 29 Mar 2019 12:48:22 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id f18sm517668lja.91.2019.03.29.12.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 12:48:21 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: ov6650: Move v4l2_clk_get() to ov6650_video_probe() helper
Date:   Fri, 29 Mar 2019 20:48:19 +0100
Message-ID: <43180252.PEphI5Jep4@z50>
In-Reply-To: <20190329183923.t7sxzqf5qa4z3yfs@kekkonen.localdomain>
References: <20190325003501.14687-1-jmkrzyszt@gmail.com> <20190325003501.14687-2-jmkrzyszt@gmail.com> <20190329183923.t7sxzqf5qa4z3yfs@kekkonen.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Friday, March 29, 2019 7:39:24 PM CET Sakari Ailus wrote:
> Hi Janus,
> 
> Thanks for the patchset.
> 
> On Mon, Mar 25, 2019 at 01:35:00AM +0100, Janusz Krzysztofik wrote:
> > ...
> >  
> >  done:
> >  	ov6650_s_power(&priv->subdev, 0);
> > +	if (ret) {
> > +eclkput:
> > +		v4l2_clk_put(priv->clk);
> 
> Could you rework the error handling, please? Labels should be outside
> conditionals. 

OK.

> See e.g. the smiapp driver
> (drivers/media/i2c/smiapp/smiapp-core.c). I've pushed my master branch
> here:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/>

I'm currently syncing my linux-media remote tracking branches with 
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git
Should I switch to a different repository, e.g. yours?

Thanks,
Janusz



