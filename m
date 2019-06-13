Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5770C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BEE2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="emZLjWch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfFMXoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:44:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43572 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFMXoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:44:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so538299qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g7boi3vIUx+9iLfyXXamOfQB8s0GSBsw2SREXSk/vlM=;
        b=emZLjWchW4yBbvfCDUkBSh+PMxU2nC0uySIYouuKeH8jZf2+RRP8ORxRUq1c6G48EN
         +oHXZrktnDWBXJqV2rN9cm3ZvuGMBEk7YP0CKWc4YtEIJwADZwHzqu/igyrvA9v/Uvzt
         L/nBIyN7XddpFYAcAyiv1xG3NJ2Iboey1ghH0jDUEmFVAxdPNXK0AMh2sPf9F1ukKc8S
         8opxqT0sSGnCjepFZcoqio0o1pgzAK2jh6CpmqL7Xi23deKnNyftEqdQc2e0MrQLMsHm
         gWBwj2rQ1FAJhaYnS0z3lhbJxMd+BLp6Pz+QAaJnPCDUvFIak47UU+whMDqDl6hXOVHg
         +Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g7boi3vIUx+9iLfyXXamOfQB8s0GSBsw2SREXSk/vlM=;
        b=dFmuCuB2IKMtopGLzs4ahfACm938wdush0mKhGj332djAGYpWWGwZladCXioHcX0OR
         dEhRoGn0O81nGYFfcv/Vrzon2h7n7gx25wkxUpMP6N+nhVkrzzeSfT4TdsLT5UZllP05
         90gY8pgX+yeEUri3scET1BCn4nlddBItWO/VEDeMoWv05FLKBMdnsyzff3kGu0gcW22o
         KAx/JsVX/dybB4/xxMXH4XtR/CUFscNpG10pXBB8yvymOOSsC4F2aHQh7+5m7O1kaTt0
         ZS/0NZLEcqlzPumU35zf6XS4J4IFrdFHiLFmpQ4N700IDjgwr/4+Tm0SqRfjAyV+7lqD
         KLIA==
X-Gm-Message-State: APjAAAXDuegBh8R/iS1tP/YCHFCiUhsxmrNAWtHtkJqo+rXTHrszeDtf
        Cz2KnTiOcrN3TsOQioHwEVhZrQ==
X-Google-Smtp-Source: APXvYqzpAVv1otDo0HQ91FihHrQL4EDya0tUX64BUv1oNZ7452dV5IuWwxGreImebgvLDtbAkimNtQ==
X-Received: by 2002:a37:795:: with SMTP id 143mr74274310qkh.140.1560469455479;
        Thu, 13 Jun 2019 16:44:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g2sm652872qkb.80.2019.06.13.16.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 16:44:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbZOA-00018T-LK; Thu, 13 Jun 2019 20:44:14 -0300
Date:   Thu, 13 Jun 2019 20:44:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 8/8] tpm: add legacy sysfs attributes for tpm2
Message-ID: <20190613234414.GJ22901@ziepe.ca>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-9-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613180931.65445-9-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:09:31AM -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Userland scripts and tests rely on certain sysfs attributes
> present in the familiar location:
> /sys/class/tpm/tpm0/device/enabled
> /sys/class/tpm/tpm0/device/owned

no, we are expecting TPM2 userspace to use the new names and
locations. TPM2 is already not compatible with TPM1

Jason
