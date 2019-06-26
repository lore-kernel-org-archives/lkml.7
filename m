Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F5C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712C7208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="svL4AoXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFZEbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:31:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFZEbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:31:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so538736pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 21:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3z6m3SSAf9dzi6GckItcH8BCeyReu+5tuH/lpHr1y9I=;
        b=svL4AoXElLa69UBtPYJXEZbtdQKGjP/1YJiTvdQGpN7WsmK1MlC29B208zuqfbwpU4
         ttUMSGa2VIYL2YGDMGdRj4wXYD9gDn3u3UnHbS8LjmgFmtkuw8E1afO6yEyiGJA/4ZFV
         H0n1LBFrWXR2dEdyVxfDA+oRGeSg+58XA4W4FpDTr47cZAqJlcc83qzUUxIgebeRdPil
         ACKb6HjqBT8SLg326ZKOxwVMZHSMRA4wA2abaG6Ru7ZdINoZHjm07VRUs1xe0I0nmNuA
         RNOjiwIAW1029+IAoXWnYSXUxONDY9K0Rpy0M0CvEVRUWidlFy+n9mXQa3qx59rqIQ7R
         9Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3z6m3SSAf9dzi6GckItcH8BCeyReu+5tuH/lpHr1y9I=;
        b=sn4YExkrSPY9wY8eiPOtK6sFCzZLVpJuVhej7mMO/eHgHKjY68mAMmWa//UfzVlCsM
         MRIHTkTg0VCZnqSJUTLvhgb0GXJbdTtieU21ZOJDtvzyOws94w2tQ4C4fgo/rOxxOkrd
         SsHN4FKYwz7vjp3iR8J/kzUTpmyVCMhhJkXoTeAjhqMGaC9x8481Wp0emgJKpVFQiH3N
         r3KE0lzohArrk+2YXNDhlGpkD5N5VIwZVZsqlXrMk3se3Qc+k5wWX/7CepeEZW5lykzP
         7nJ8xuDsZpkhSQIiiAdkk1YgvwNU5IsSZttSj54Ua4Ms7WCBLb4br+Dx55GKJA/M3IFS
         zjLQ==
X-Gm-Message-State: APjAAAUognfZCcb4zoGeE3UXyBnrErxnCfKDni2/uyDGVCEAEUebE+WQ
        ZL388WbdoD8ivEqG4biMl6KTMw==
X-Google-Smtp-Source: APXvYqyH2EzWemz4wKkvwI/pC+bUNAK6TGqYc/Kliu7VARqUH2Nlt+4+Cwrnre1mqCY/BXRZHOXZIw==
X-Received: by 2002:a63:de45:: with SMTP id y5mr797887pgi.113.1561523461441;
        Tue, 25 Jun 2019 21:31:01 -0700 (PDT)
Received: from localhost ([38.98.37.136])
        by smtp.gmail.com with ESMTPSA id y12sm19242910pfn.187.2019.06.25.21.31.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 21:31:00 -0700 (PDT)
Date:   Tue, 25 Jun 2019 21:30:52 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
Message-ID: <20190626043052.GF212690@google.com>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190624223707.GH203031@google.com>
 <20190625035313.GA13239@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625035313.GA13239@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:53:13AM +0800, Greg Kroah-Hartman wrote:
> On Mon, Jun 24, 2019 at 03:37:07PM -0700, Sandeep Patil wrote:
> > We are trying to make sure that all (most) drivers in an Aarch64 system can
> > be kernel modules for Android, like any other desktop system for
> > example. There are a number of problems we need to fix before that happens
> > ofcourse.
> 
> I will argue that this is NOT an android-specific issue.  If the goal of
> creating an arm64 kernel that will "just work" for a wide range of
> hardware configurations without rebuilding is going to happen, we need
> to solve this problem with DT.  This goal was one of the original wishes
> of the arm64 development effort, let's not loose sight of it as
> obviously, this is not working properly just yet.

I believe the proposed solution in this patch series is just that. I am not
sure what the alternatives are. The alternative suggested was to reuse
pre-existing dt-bindings for dependency based probe re-ordering and resolution.

However, it seems we had no way to *really* check if these dependencies are
the real. So, a device may or may not actually depend on the other device for
probe / initialization when the dependency is mentioned in it's dt node. From
DT's point of view, there is no way to tell this ..

I don't know how this is handled in x86. With DT, I don't see how we can do
this unless DT dependencies are _really_ tied with runtime dependencies (The
cycles would have been apparent if that was the case.

Honestly, the "depends-on" property suggested here just piles on to the
existing state. So, it is somewhat doubling the exiting bindings. It says,
you must use depends-on property to define probe / initialization dependency.
The existing bindings like 'clock', 'interrupt', '*-supply' do not enforce
that right now, so you will have device nodes that have these bindings right
now but don't necessarily need them for successful probe for example.

> 
> It just seems that Android is the first one to actually try and
> implement that goal :)

I guess :)

- ssp

> 
> thanks,
> 
> greg k-h
