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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F821848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M46IeemI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfIRWLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:11:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44765 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfIRWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:11:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id q11so780250lfc.11;
        Wed, 18 Sep 2019 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGtTJRv0WAexJPi7bvgwGF4WgJCfkx1DCaTltgjAlVU=;
        b=M46IeemIRzYpqjkDyfHzXQHjIMUSi3rXxve1/kyPLiLOZFIpbRs8kjk5rKjaeI/v9g
         lqlYEbDEsUSSpMSMS6MP57UWyL1UMxpC4k/9Yo9iKKxF84pFZpnDBw1Ff32x5Io/cJi6
         zhZG/s2fIJj666H3FR+7fBZgaUv2vtPN5zN12uxmzGjJJDWj7CKQ7i2usPRiKaEp48Pj
         yLVStXhnaEsQSKXuA01iXi8UBaQcDDe9MAAsZl26/2qvOL6xzcJ5Vu8OWDxzkNLac+Ee
         M57mFSK30pqdFAClIhonZzQeBVOmzbq+Kkz6as+Cbp4p5vt/d1qNEGzoKo319WSx72IK
         ysmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGtTJRv0WAexJPi7bvgwGF4WgJCfkx1DCaTltgjAlVU=;
        b=Sf1amaxbfhcL97Ebu1FGopF0V9GsaAsZsAyt9LmkvN346eNB7ATHOChsr9aP67BiP/
         GZ+6drtQAcoZziiWjFbcMlSVaZkahtvAPWfmMjAMopf1qGMNn8FeljMn8Y01zgJ35NRN
         v/yQ1crJAuw887FVUx/1zBcCj2NhnZtiO7q6JusoovOlm4p/++D5SywJUyDMTliPI9Ll
         HDskGbyFNajlOeFJMbYo7yq0ckYswvDRRB0IL8J4/o8NlaWNOu18+ifwHh5Q1J9N7kQ6
         QDXVk/+JXb6Oc+3QIy0ct407JTtQcg64wjvd3SkLCM8vCUMyM948tiQopPDZVEGZChzr
         6lsw==
X-Gm-Message-State: APjAAAUDLjSMbuVKUWU3c/40ntlK7YT78AwgZHf09vGrnRn1NM3Z1Arr
        6FbNF6dcDZbgVVEw94GM1VU=
X-Google-Smtp-Source: APXvYqzL7f00j06Ypzt5xtG8v75hLtY/W5pp2xqL7Oia3QNrEFKBxmrMLf9qximYIET7EbJrsk8jIw==
X-Received: by 2002:a19:14f:: with SMTP id 76mr3142855lfb.92.1568844701534;
        Wed, 18 Sep 2019 15:11:41 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id y3sm1203415lfh.97.2019.09.18.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 15:11:40 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAiAo-0002FA-7J; Thu, 19 Sep 2019 01:11:42 +0300
Date:   Thu, 19 Sep 2019 01:11:42 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
Message-ID: <20190918221142.GB4859@jeknote.loshitsa1.net>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
 <f578a65b-af02-5fe8-dd59-9918c000da64@redhat.com>
 <20190918114224.GA23318@jeknote.loshitsa1.net>
 <029c7865-b9b3-1e58-7092-6d8495de0116@redhat.com>
 <20190918203332.GA4859@jeknote.loshitsa1.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918203332.GA4859@jeknote.loshitsa1.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:33:32PM +0300, Yauhen Kharuzhy wrote:
> On Wed, Sep 18, 2019 at 10:12:43PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 18-09-2019 13:42, Yauhen Kharuzhy wrote:
> > > On Wed, Sep 18, 2019 at 11:20:21AM +0200, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 17-09-2019 21:45, Yauhen Kharuzhy wrote:
> > > > > Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> > > > > hardware has TypeC connector and register related devices described as
> > > > > I2C connections in the _CRS resource.
> > > > > 
> > > > > There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
> > > > > USB B connector exists. It has INT33FE device in the DSDT table but
> > > > > there are only two I2C connection described: PMIC and BQ27452 battery
> > > > > fuel gauge.
> > > > > 
> > > > > Splitting existing INT33FE driver allow to maintain code for USB type B
> > > > > (AB) connector variant separately and make it simpler.
> > > > > 
> > > > > Split driver to intel_cht_int33fe_common.c and
> > > > > intel_cht_int33fe_{typeb,typec}.c. Compile all this source to one .ko
> > > > > module to make user experience easier.
> > > > > 
> > > > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > > > 
> > > > Thank you for doing this, this version looks much better IMHO.
> > > > 
> > > > Note that this does not apply to Linus' current master, please
> > > > rebase. Specifically this conflicts with this patch:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78cd4bf53635d3aeb73435bc89eb6eb39450f315
> > > > 
> > > > Which just got merged. Instead of rebasing on Linus' master
> > > > (which is always a bit adventurous to use during the merge window)
> > > > you can also cherry-pick that single commit on top of v5.3
> > > > and use that as a base.
> > > > 
> > > > Note that that patch makes changes to struct cht_int33fe_data
> > > > specifically it drops the:
> > > > 
> > > > 	struct fwnode_handle *mux;
> > > > 
> > > > Member, so when rebasing you should drop that in the new
> > > > version of the struct on common.h .
> > > > 
> > > > Besides that this need a rebase, overall this looks good, I have some
> > > > small remarks inline:
> > > 
> > > Arghh.. OK, I have rebased the patch but at current torvalds kernel
> > > i2c_acpi_new_device() fails with -EPROBE_DEFER at my hw, so I cannot check if it
> > > is fully working. But I will resend patch anyway soon, this error should
> > > not be related to the patch content.
> > 
> > Are you sure it is not working? -EPROBE_DEFER is normal(ish) it just means
> > that the i2c-controller driver for the bus has not initialized yet.
> > 
> > If you are building the i2c_designware or acpi_lpss drivers as module, or if
> > you are building the intel_cht_int33fe code into the kernel, then this
> > is more or less expected to happen.
> 
> I would agree but i2cdetect/i2cget works for this bus as expected. I
> remember that I met this bug at one of previous iterations, hm... As I remember
> it was caused by this commit:
> 00500147cbd3fc51353d0d003eaa9d31c72c0d50 drivers: Introduce device lookup variants by ACPI_COMPANION device.
> 
> This needs to be investigated.

It was reverted by commit merged today, so it is not an issue anymore:

commit 644bf60088955421051e716ab9c8fe7fb7997fd7
Author: Suzuki K Poulose <suzuki.poulose@arm.com>
Date:   Thu Aug 1 11:20:24 2019 +0100

    i2c: Revert incorrect conversion to use generic helper



> > You can do "ls /sys/bus/i2c/devices" to check if it did succeed on
> > later re-probe attempts (the fuel-gauge device should be there if
> > things succeeded).
> > 
> > And you should probably do one more version, suppressing the dev_err
> > on -EPROBE_DEFER like e.g. this snippet from the typec code:
> 
> OK, -EPROBE_DEFER was unexpected here for me...
> 
>  
> 
> -- 
> Yauhen Kharuzhy

-- 
Yauhen Kharuzhy
