Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC69C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439421783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfJBKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:46:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:11672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJBKqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 03:46:38 -0700
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="392802855"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 03:46:36 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Mat King <mathewk@google.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
In-Reply-To: <20191002102428.zaid63hp6wpd7w34@holly.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com> <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan>
Date:   Wed, 02 Oct 2019 13:46:20 +0300
Message-ID: <8736gbbf2b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
>> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
>> > Resending in plain text mode
>> >
>> > I have been looking into adding Linux support for electronic privacy
>> > screens which is a feature on some new laptops which is built into the
>> > display and allows users to turn it on instead of needing to use a
>> > physical privacy filter. In discussions with my colleagues the idea of
>> > using either /sys/class/backlight or /sys/class/leds but this new
>> > feature does not seem to quite fit into either of those classes.
>> >
>> > I am proposing adding a class called "privacy_screen" to interface
>> > with these devices. The initial API would be simple just a single
>> > property called "privacy_state" which when set to 1 would mean that
>> > privacy is enabled and 0 when privacy is disabled.
>> >
>> > Current known use cases will use ACPI _DSM in order to interface with
>> > the privacy screens, but this class would allow device driver authors
>> > to use other interfaces as well.
>> >
>> > Example:
>> >
>> > # get privacy screen state
>> > cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
>> > enabled 0: privacy disabled
>> >
>> > # set privacy enabled
>> > echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
>> >
>> >  Does this approach seem to be reasonable?
>> 
>> What part of the userspace would be managing the privacy screen? Should
>> there be a connection between the display and the privacy screen that
>> covers the display? How would the userspace make that connection if it's
>> a sysfs interface?
>> 
>> I don't know how the privacy screen operates, but if it draws any power,
>> you'll want to disable it when you switch off the display it covers.
>> 
>> If the privacy screen control was part of the graphics subsystem (say, a
>> DRM connector property, which feels somewhat natural), I think it would
>> make it easier for userspace to have policies such as enabling the
>> privacy screen automatically depending on the content you're viewing,
>> but only if the content is on the display that has a privacy screen.
>
> Connectors versus sysfs came up on a backlight thread recently.
>
> Daniel Vetter wrote an excellent summary on why it has been (and still
> is) difficult to migrate backlight controls towards the DRM connector
> interface:
> https://lkml.org/lkml/2019/8/20/752
>
> Many of the backlight legacy problems do not apply to privacy screens
> but I do suggest reading this post and some of the neighbouring parts
> of the thread. In particular the ACPI driver versus real driver issues
> Daniel mentioned could occur again. Hopefully not though, I mean how
> wrong can a 1-bit control go? (actually no... don't answer that).
>
> It would definitely be a shame to build up an unnecessary sysfs legacy
> for privacy screens so definitely worth seeing if this can use DRM
> connector properties.

Indeed. I'm painfully aware of the issues Daniel describes, and that's
part of the motivation for writing this.

Obviously the problem with associating the privacy screen with the DRM
connector is that then the kernel has to make the connection, somehow,
instead of just making it a userspace problem.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
