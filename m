Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09C7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8414921901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H4APkLXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfGVTOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:14:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34459 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbfGVTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:14:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so19599899plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9BbPnmI+pHoI/NQDPXVHcO4RcOKDp2TZ+FeQcswyuI=;
        b=H4APkLXJRK/q7ukCstH9qo49f7JrC1BR5KVMbG+8RY+d6vqMcg1vyfHihn4f1tfloM
         WuNKUwAJlufYR0Qn0fAu83Z8xx1H7ZanZPEpW13uQ6ahzZm+rU5ixiOOUe+MRjd5xa+l
         kzekOMj36vdf9V0CWtNVbnu6PnNGDIpzEkEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9BbPnmI+pHoI/NQDPXVHcO4RcOKDp2TZ+FeQcswyuI=;
        b=LPOXHx/Xlypdf5dj7auVF6nWBXpiMu8xSCWeZ2B6kBbt/Wf/qWrgNtsZF67uhwYrW9
         LGmrqvy0PLghoGrQgGUo49ufpoTWvEcEk1t/YoIfZkUFtDmHnQhFt3NoulON1OQtj2mz
         wBcb4ZwUfS2E/AcRRrNUa/0zTyxyU8Tt5UbHaiZObRtK7gR/qJjf/vC8pxpsGg9jF/ud
         G4KKY4kI2SJLKyH+2ikL2vjjVxoT9VtPbOF5AANoug3UOfjXHoh36GPLtGvGYB9Vu73v
         SjIYdf1crWv+a0ODoeKkpLCDDDOuU4ZcogHE9K6rmDC2/sGO4y5jU6WM/BszrkQ0aC8t
         iyaw==
X-Gm-Message-State: APjAAAX6c47rQEALH29QQ6r5kYfDz79NQKB4+4EWjc5qT291H7ycKoSM
        ruiPLO9BIR1Xuc+KJwmKBA894A==
X-Google-Smtp-Source: APXvYqye8KADnaKfIO2xcVLE1cwxtty5tPY77LPyY5ryPz/+MASHRSWvD9J4mt/y+V4sUlO4fxKuxg==
X-Received: by 2002:a17:902:aa5:: with SMTP id 34mr79416847plp.166.1563822854072;
        Mon, 22 Jul 2019 12:14:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t96sm36367885pjb.1.2019.07.22.12.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 12:14:13 -0700 (PDT)
Date:   Mon, 22 Jul 2019 12:14:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: net: realtek: Add property to
 configure LED mode
Message-ID: <20190722191411.GW250418@google.com>
References: <20190703193724.246854-1-mka@chromium.org>
 <20190703193724.246854-6-mka@chromium.org>
 <e8fe7baf-e4e0-c713-7b93-07a3859c33c6@gmail.com>
 <20190703232331.GL250418@google.com>
 <CAL_JsqL_AU+JV0c2mNbXiPh2pvfYbPbLV-2PHHX0hC3vUH4QWg@mail.gmail.com>
 <20190722171418.GV250418@google.com>
 <20190722190133.GF8972@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722190133.GF8972@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Jul 22, 2019 at 09:01:33PM +0200, Andrew Lunn wrote:
> On Mon, Jul 22, 2019 at 10:14:18AM -0700, Matthias Kaehlcke wrote:
> > I'm working on a generic binding.
> > 
> > I wonder what is the best process for reviewing/landing it, I'm
> > doubting between two options:
> > 
> > a) only post the binding doc and the generic PHY code that reads
> >    the configuration from the DT. Post Realtek patches once
> >    the binding/generic code has been acked.
> > 
> >    pros: no churn from Realtek specific patches
> >    cons: initially no (real) user of the new binding
> > 
> > b) post generic and Realtek changes together
> > 
> >    pros: the binding has a user initially
> >    cons: churn from Realtek specific patches
> > 
> > I can do either, depending on what maintainers/reviewers prefer. I'm
> > slightly inclined towards a)
> 
> Hi Matthias
> 
> It is normal to include one user of any generic API which is added,
> just to make is clear how an API should be used.

as of now it isn't even an API, the phy_device populates a new array
in its struct with the values from the DT. PHY drivers access the
array directly. Is it still preferable to post everything together?

(maybe I'm too concerned about 'noise' from the driver patches while
 we are figuring out what exactly the binding should be).

Thanks

Matthias
