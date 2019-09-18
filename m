Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0CBC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184D21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoiNHZHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfIRLmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:42:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35130 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfIRLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:42:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so6586775wrt.2;
        Wed, 18 Sep 2019 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8xGyacSjSI79wvxydAPMNQhz2XUtmEOpWuQK2TP5Jcw=;
        b=KoiNHZHrla/1XxwQAUT8bteHDmTHzbt9AV2nGb2Fy1zxytwetrAT4Ll9qfpeNpTp0J
         1jBL8Gnnd9By2c7croJ5oAJQevcdHPooLZDMSF2qnMKIxza+V+0OnyDJo77h3jZ/cZY5
         z5LElMhqpFnzuJ4CU3Gp9S2ogVPc/QyYwUrl4M/3vg8woVoY+16Cb9P/V7BsiPXklo6s
         z+UMu3lfHD9yXghF/wkcXHtE09+EEX19iUGCT6B9hrdp5KbUZ2Vm0IkoVsi2RCrw9bxB
         L+Wj6pnp2EEc78n3Eo0CBWLUJHsJsiRXFpRy1eQNiIN6cIcwTnd6gNXchlWbGxtQX4hE
         CfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xGyacSjSI79wvxydAPMNQhz2XUtmEOpWuQK2TP5Jcw=;
        b=FJtonkFzkNJVj5e09ZeLKhGrNZTRAWrBU4vMkLrvjhJLiCInpay+Pl+24pO4eAXLcr
         TvP0+YdK6SPMhC3QwO1Z04g8qLyaENELYZuh+5m4HIf+PQ+GrwREy8cE6+c7aqhq2Vjt
         lILhRmsAslDqvn3fNRGAuq/EH1uc0nEL7Z+NUjqhm29bZ8iiC+en5mfMTY1Qcy8KcdyW
         yFYe29v3G2J/UaIh8lrEuTXaL6LqknppFWrk/SnwFUTCJpMMbrb38Qe37x9mybr8AQVl
         gYYU5xvo1tlocOswWj2MWQCiMPU1xUBmvIHdPxdECtkKj/u/jveRU3RRfFWMTPRmeZVT
         wK/g==
X-Gm-Message-State: APjAAAXtQATFgB1Rq6iQjFsnKvWYOfEmgHKi5SBTgIF6gqOS5EsYNYtl
        +y/S5Eer8OP+XyS0WwPY2Kg=
X-Google-Smtp-Source: APXvYqxJyr4xqAiCKjS9sHPxfmlPZVo1zbtNlVrHE3CUd6LL9nUkIMHEZJrgMq08qVR2kpRJ/hbFHQ==
X-Received: by 2002:adf:df81:: with SMTP id z1mr2845467wrl.295.1568806942580;
        Wed, 18 Sep 2019 04:42:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-vpdn-93-125-15-224.telecom.by. [93.125.15.224])
        by smtp.gmail.com with ESMTPSA id y3sm6166881wmg.2.2019.09.18.04.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 04:42:22 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAYLo-0007WY-CJ; Wed, 18 Sep 2019 14:42:24 +0300
Date:   Wed, 18 Sep 2019 14:42:24 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
Message-ID: <20190918114224.GA23318@jeknote.loshitsa1.net>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
 <f578a65b-af02-5fe8-dd59-9918c000da64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f578a65b-af02-5fe8-dd59-9918c000da64@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:20:21AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-09-2019 21:45, Yauhen Kharuzhy wrote:
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
> > 
> > Split driver to intel_cht_int33fe_common.c and
> > intel_cht_int33fe_{typeb,typec}.c. Compile all this source to one .ko
> > module to make user experience easier.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> 
> Thank you for doing this, this version looks much better IMHO.
> 
> Note that this does not apply to Linus' current master, please
> rebase. Specifically this conflicts with this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78cd4bf53635d3aeb73435bc89eb6eb39450f315
> 
> Which just got merged. Instead of rebasing on Linus' master
> (which is always a bit adventurous to use during the merge window)
> you can also cherry-pick that single commit on top of v5.3
> and use that as a base.
> 
> Note that that patch makes changes to struct cht_int33fe_data
> specifically it drops the:
> 
> 	struct fwnode_handle *mux;
> 
> Member, so when rebasing you should drop that in the new
> version of the struct on common.h .
> 
> Besides that this need a rebase, overall this looks good, I have some
> small remarks inline:

Arghh.. OK, I have rebased the patch but at current torvalds kernel
i2c_acpi_new_device() fails with -EPROBE_DEFER at my hw, so I cannot check if it
is fully working. But I will resend patch anyway soon, this error should
not be related to the patch content.

> > +	data->hw_type = ret;
> > +	data->dev = dev;
> > +
> > +	switch (data->hw_type) {
> 
> I suggested adding hw_type to data so that it could be used to
> select the right remove function in cht_int33fe_remove(),
> since you are using a remove function pointer in data for this
> (which is fine), there is no reason to store hw_type in
> cht_int33fe_data anymore, please drop this and change the
> 
> 	switch (data->hw_type) {
> 
> to:
> 
> 	switch (ret) {

OK, sure

> 
> p.s.
> 
> I've done the rebase myself and I'm building a kernel with my re-based version of this
> patch to test it on a typec device. I will get back to you with the results
> (I expect things will just work, just making sure).
> 

-- 
Yauhen Kharuzhy
