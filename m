Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4BECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0D2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439578AbfJXMGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:06:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:19192 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733180AbfJXMGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:06:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 05:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="210143295"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 24 Oct 2019 05:06:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 24 Oct 2019 15:06:28 +0300
Date:   Thu, 24 Oct 2019 15:06:28 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Puma Hsu <pumahsu@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Albert Wang <albertccwang@google.com>,
        Chien Kun Niu <rickyniu@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector
 orientation
Message-ID: <20191024120346.GC15396@kuha.fi.intel.com>
References: <20191022085924.92783-1-pumahsu@google.com>
 <20191023083221.GB8828@kuha.fi.intel.com>
 <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net>
 <20191023142900.GA15396@kuha.fi.intel.com>
 <20191023150126.GA16612@roeck-us.net>
 <20191023155757.GB15396@kuha.fi.intel.com>
 <CAGCq0LZGz04JCTEJXrBqs4ENybQih6zKWTacq9T9DKPNOQAfMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGCq0LZGz04JCTEJXrBqs4ENybQih6zKWTacq9T9DKPNOQAfMw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 24, 2019 at 05:02:18PM +0800, Puma Hsu wrote:
> Yes, generally this might be purely informational or be a dynamically
> debuggable
> mechanism for end user as I mentioned in previous discussion
> thread(https://lkml.org/lkml/2019/10/22/198).
> Could I know if it is not suitable that we expose a file for
> informational usage?
> 
> If everyone agreed above, about the definition of “unknown” and the condition
> “don’t know the orientation”, what about adding additional return value?
>   1. For original “unknown”, it is a generic unknown state which can
> indicate no
>       matter connector is disconnected, cannot specify which cc side
> is configured(such as Ra-Ra),
>       or even driver can not know the orientation.
>   2. New additional value “unavailable”, it can be used to
> specifically explicate that
>       driver can not know the orientation.
> Take UCSI as example, it can use generic “unknown” or “unavailable” if
> it wants.
> But if it exposes “unavailable”, then application in user space can
> know that this attribute is not useful.
> 
> I summarize the proposal definition below:
>  - unknown (generic unknown. driver don’t or can’t know the polarity,
>                       e.g. disconnected, both cc1 and cc2 are the same, )
>  - normal (configured in cc1 side)
>  - reversed (configured in cc2 side)
>  - unavailable (not support the polarity detection)

Now the attribute would be supplying two types of information:

        1) Does the driver know the orientation
        2) The current orientation

Let's not do that! If you really need this, then just implement the
".is_visible" callback with it. You just need to add a flag to the
struct typec_capability that tells does the driver know the
orientation or not. Something like:

        unsigned int orientation_aware:1;

We already "hide" the identity information if the underlying driver
is unable to supply it. By making this attribute optional as well (by
hiding it when it's not known), the style of exposing the information
is kept the same throughout the class.

thanks,

-- 
heikki
