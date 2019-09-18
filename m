Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34B0C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15EC21920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfIRLil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:38:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:51956 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfIRLik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:38:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 04:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="202041528"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 18 Sep 2019 04:38:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 18 Sep 2019 14:38:35 +0300
Date:   Wed, 18 Sep 2019 14:38:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
Message-ID: <20190918113835.GA16243@kuha.fi.intel.com>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917194507.14771-2-jekhor@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:45:07PM +0300, Yauhen Kharuzhy wrote:
> Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> hardware has TypeC connector and register related devices described as
> I2C connections in the _CRS resource.
> 
> There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
> USB B connector exists. It has INT33FE device in the DSDT table but
> there are only two I2C connection described: PMIC and BQ27452 battery
> fuel gauge.
> 
> Splitting existing INT33FE driver allow to maintain code for USB type B
> (AB) connector variant separately and make it simpler.

Sorry, but "Type B" is even more confusing here. Type B refers to the
Standard-B USB connector, so _not_ the micro connector family. You can
check the connector definitions from the latest USB 3.2 specification.
The standard-b definition goes something like this:

        "The standard _Type-B_ connector defined by the USB x specification."

Note that all the five supported connectors are listed in ch5
"Mechanical":

        Standard-A
        Standard-B
        Micro-B
        Micro-AB
        Type-C

So what was the problem with names that refer to the micro connector
family, for example "micro-ab" or "micro-b"?


thanks,

-- 
heikki
