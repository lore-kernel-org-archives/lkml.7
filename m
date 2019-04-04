Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00ECC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807DE20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554362620;
	bh=vpKAg7PduDdyzEpGHCQ1rwx8fAJ7UhJRV/ZQIYJdbZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UDSDQ+/IDySFEVV1sFfZgQ4lsHuDp7WMeL5fs51QKmFZu8Y4fZfvK1LVwzKTMANfB
	 Q3N87yxST6reRKNBk2YTUauISv83e+T+R0Rfi5/ssdq70e3uUesYhGYvAMChaotX8I
	 1Fv/bJQpzR8TbJd2pm5AL8smn4no/wjRylYa2xNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfDDHXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:23:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33106 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:23:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id v14so1038472lfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOtFRp3tT+XzxfQtCf8FddN72A2buzuK/r8cjXcC3nw=;
        b=S5+iXLSKHd98eUKwxTNB+qyqLrs7gJg0L2ORk0wiZ4iIiWX7Gj3XtP4SvCkv58ymDL
         bqjnHN4utb4PNSQLrtqlPTT3lQFOPT5NazIV+fWCjtOM+jKYDkE+I1M9Cjo3LkVzYHkU
         gJJpO0h7hm2dKGpkvo5r79Ew8+s+bowOyafNXToVE0+b07/ZCdGjtwr/O8l6ymNl3Z2H
         Kfxn1cIvkveszmLPILI8yoPWHKYqzcmbyP1azYtVfL+pCwnQRpnrWhMGBzqfv7vSqBOk
         dBaGS86/l9tPmer4VSHe5BVYM+unCySB/BzHzbK2Ht8LkoCZ1Qb4Foa17pnleXXFs+nG
         QLTg==
X-Gm-Message-State: APjAAAVLyt9BWXcX9F/kL/gYRVqAoTtTUBCMS/Hfvs323Z8ucLQBOawe
        UJ50InefPyTJ5Y953TEKeKc=
X-Google-Smtp-Source: APXvYqysRV9EWa13TJKRfo7AracsfrK7COohCczcwHDpF/LWOm1HW9PJJTMytxeYinJqEsKK9eFOdQ==
X-Received: by 2002:ac2:5205:: with SMTP id a5mr2271569lfl.102.1554362616593;
        Thu, 04 Apr 2019 00:23:36 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w22sm3744689ljd.42.2019.04.04.00.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 00:23:35 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hBwjA-0003SU-Gf; Thu, 04 Apr 2019 09:24:00 +0200
Date:   Thu, 4 Apr 2019 09:24:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: power_supply: Use struct_size() helper
Message-ID: <20190404072400.GA29917@localhost>
References: <20190403205801.GA19762@embeddedor>
 <m37ecap7pc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37ecap7pc.fsf@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:09:51AM +0100, Rui Miguel Silva wrote:
> Hi Gustavo,
> Thanks a lot for the patch.
> 
> On Wed 03 Apr 2019 at 21:58, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded 
> > version
> > in order to avoid any potential type mistakes, in particular in 
> > the
> > context in which this code is being used.
> >
> > So, replace code of the following form:
> >
> > sizeof(*resp) + props_count * sizeof(struct 
> > gb_power_supply_props_desc)
> >
> > with:
> >
> > struct_size(resp, props, props_count)
> >
> > This code was detected with the help of Coccinelle.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> What are the odds of 2 people changing same code in greybus in
> the same day :).

Well, I only noticed the bug in the current code, when reviewing
Gustavo's diff. ;)

Johan
