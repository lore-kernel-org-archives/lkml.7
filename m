Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8509321897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBQDE9Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfIRLww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:52:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40592 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfIRLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:52:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so2232593wmj.5;
        Wed, 18 Sep 2019 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cymeMj7ZGM8MDmBXapGMRRNr8BctclgyiDGVRif1ROc=;
        b=oBQDE9XvO+22bQtg8FT3U1/6ouTb+CFjtaQ/Py34IGPxYxOUCcUgnYnte7kl8FL4NV
         APdK+X8XPot9IgtKobxUeFZ8BO0FPEWzh9jP/s9kMvqx61VzsIZx+J9x9hcDl4x0uxq6
         2RSx80kkhyJ9uBtjI7WBn9gkkIk3h7RFhh91Wg7kAyvdVN8y9KmhQhS66OIZqUj6lkMH
         bljo1SYesmIUycVNnx/UiZJ6XkBqISo4pp4O37cWeDt8Nw5MkoSTtGU5XyAvsI2+Cyta
         xAyc/OuZS5UqNnLJATzRgHCqLNZ1IM0p8PF3Wu/AaP0e/7s7D9684n2gDqne8YzoHJkA
         s0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cymeMj7ZGM8MDmBXapGMRRNr8BctclgyiDGVRif1ROc=;
        b=V3zFxagRND62h1QMbWIbuh+SXzNokBly7ytABUY0S8+mtFv2rVR42J6vOvRpqBNO0f
         YJ6OV5J7CT/tYW38pRiRYJunEOsdxePHghY/stD9hpEs1EbS/qVRIorT78IGEyV/MuaU
         IO4ZNNirtNkl3ifK+mNqykxr64WL3BrjmUY1yatJR/W/E9iLQ/5IFw9shSWrBPUgfH3s
         T8pNZJZZDPHubgErbas9srzeut+sSw2p9JT38Heja7hHUyaeMieltXxs+tiJwC1z/a65
         aE8r9mRaZbRMA1dwEQv0TXNZnaVtqO+ozsn7H+F9bRCypRxuvv/zQUpqrigaStiVzSCn
         ZYzA==
X-Gm-Message-State: APjAAAWQu1YBeR6nA65zDXB4lPTJ/LU29QfVKYUMmtfRxUq2bfAZPQQD
        pg7mTOPRZmviyIfsli3GcG4=
X-Google-Smtp-Source: APXvYqydQU/kPkPcaDn2CT3I+GwAY2Oi0qIFJu2cxKpwSKRDCZb2eYA61qN+wLM74d5rS2Qw/Nuy5Q==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr2594242wmk.84.1568807569891;
        Wed, 18 Sep 2019 04:52:49 -0700 (PDT)
Received: from localhost.localdomain (dynamic-vpdn-93-125-15-224.telecom.by. [93.125.15.224])
        by smtp.gmail.com with ESMTPSA id b144sm3667279wmb.3.2019.09.18.04.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 04:52:49 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAYVv-0007bj-Gr; Wed, 18 Sep 2019 14:52:51 +0300
Date:   Wed, 18 Sep 2019 14:52:51 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
Message-ID: <20190918115251.GA28946@jeknote.loshitsa1.net>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
 <20190918113835.GA16243@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918113835.GA16243@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 02:38:35PM +0300, Heikki Krogerus wrote:
> On Tue, Sep 17, 2019 at 10:45:07PM +0300, Yauhen Kharuzhy wrote:
> > Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> > hardware has TypeC connector and register related devices described as
> > I2C connections in the _CRS resource.
> > 
> > There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
> > USB B connector exists. It has INT33FE device in the DSDT table but
> > there are only two I2C connection described: PMIC and BQ27452 battery
> > fuel gauge.
> > 
> > Splitting existing INT33FE driver allow to maintain code for USB type B
> > (AB) connector variant separately and make it simpler.
> 
> Sorry, but "Type B" is even more confusing here. Type B refers to the
> Standard-B USB connector, so _not_ the micro connector family. You can
> check the connector definitions from the latest USB 3.2 specification.
> The standard-b definition goes something like this:
> 
>         "The standard _Type-B_ connector defined by the USB x specification."
> 
> Note that all the five supported connectors are listed in ch5
> "Mechanical":
> 
>         Standard-A
>         Standard-B
>         Micro-B
>         Micro-AB
>         Type-C
> 
> So what was the problem with names that refer to the micro connector
> family, for example "micro-ab" or "micro-b"?

Only one problem: there is no difference between micro B, micro AB, mini
B or Standard-B types of connectors from this driver point of view – all
of them can be used for device charging. Now we have only two kind of
hardware with INT33FE pseudo-device: with Micro-B and Type-C connectors
but other kind may exist. TypeB is not standartized but it seemed to me
a good generalization of "USB connectors to charger connection but not
Type-C". No problem to change it to other suitable name, 'simple', 'dumb',
'non-TypeC' or 'micro-B'. All this names are not ideal.

-- 
Yauhen Kharuzhy
