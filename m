Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ADEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E4622CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfICITD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:19:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:51418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfICITC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:19:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 01:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="198721560"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 01:18:59 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Sep 2019 11:18:58 +0300
Date:   Tue, 3 Sep 2019 11:18:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lee.jones@linaro.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Tweak I2C SDA hold time on GemniLake to make touchpad work
Message-ID: <20190903081858.GA2691@lahna.fi.intel.com>
References: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jarkko

On Tue, Sep 03, 2019 at 04:10:27PM +0800, Chris Chiu wrote:
> Hi,
> 
> We're working on the acer Gemnilake laptop TravelMate B118-M for
> touchpad not working issue. The touchpad fails to bring up and the
> i2c-hid ouput the message as follows
>     [    8.317293] i2c_hid i2c-ELAN0502:00: hid_descr_cmd failed
> We tried on latest linux kernel 5.3.0-rc6 and it reports the same.
> 
> We then look into I2C signal level measurement to find out why.
> The following is the signal output from LA for the SCL/SDA.
> https://imgur.com/sKcpvdo
> The SCL frequency is ~400kHz from the SCL period, but the SDA
> transition is quite weird. Per the I2C spec, the data on the SDA line
> must be stable during the high period of the clock. The HIGH or LOW
> state of the data line can only change when the clock signal on the
> SCL line is LOW. The SDA period span across 2 SCL high, I think
> that's the reason why the I2C read the wrong data and fail to initialize.
> 
> Thus, we treak the SDA hold time by the following modification.
> 
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -97,7 +97,8 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
>  };
> 
>  static struct property_entry bxt_i2c_properties[] = {
> -       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
> +       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
>         PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
>         PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
>         { },
> 
> The reason why I choose sda hold time is by the Table 10 of
> https://www.nxp.com/docs/en/user-guide/UM10204.pdf, the device
> must provide a hold time at lease 300ns and and 42 here is relatively
> too small. The signal measurement result for the same pin on Windows
> is as follows.
> https://imgur.com/BtKUIZB
> Comparing to the same result running Linux
> https://imgur.com/N4fPTYN
> 
> After applying the sda hold time tweak patch above, the touchpad can
> be correctly initialized and work. The LA signal is shown as down below.
> https://imgur.com/B3PmnIp
> 
> The chart which has yellow mark is the tweak version, the red marks
> the original version.
> 
> I need suggestions about whether if the hold time is the value I can tweak?
> Or I should modify sda falling time? Please help if any better idea.
> 
> Thanks
