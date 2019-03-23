Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED876C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC3C218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Lv6DAAod";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxZpwwAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfCWCLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:11:33 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39073 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbfCWCLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:11:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C05FF35D2;
        Fri, 22 Mar 2019 22:01:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 22 Mar 2019 22:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vQcshrf2Tv44CFwHKAd0s5/+CM5
        J+hkjPgjTlgQ0wLs=; b=Lv6DAAodz4kP7LtZuwROSKHaPCelsle6B6jkfT+HIRC
        93BXuHzavW3i6g3Dk8K6tDxDzcE2UKgn/y8xmAH9lBHS9RqdoFiREvtz9lw6s+AK
        lGtlkUdCmKUqRDwDHDjvAcKqJ6yNe20NCwXEpp985+VwPPIEl+1Lv7bTcaeS0V1f
        TvCzcv1uGVz0PZ0JsOYTRVlCiEkXa0wzLv97UiXJhCPeeL8oIPdcsBIF+tALgj0M
        5phXpMk6r2PCGUGRXf/T8UJ0nrignEP+luPM0FGbHjWYz+3OjZ1ZGHkuzyxfNBeY
        WOYDXR9AtNgEx+OzH4yge/4VRvdgfUgTmyZuiCV52IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vQcshr
        f2Tv44CFwHKAd0s5/+CM5J+hkjPgjTlgQ0wLs=; b=GxZpwwAoeK0q4hjNkwyK1T
        uco0C4WELQXKM8rUVrmuLdclAc93xEJHWvQrdM7pSs6oXdV/5U/J5ubqRTbc8Uvl
        QBfevv+/nu/NKTpAAxI+eIDveqKyTYWycEHHxgVgFGVT0+xIA+lfjYAdeKJu6jAe
        Yz9Dg1CXbCTZYQOyKa37ss1Y7HfF/+3QY96Bt0h0ORfOvjdzthirW+xQnX2pJooL
        tKkU/Khk4AsxmXzcA1qaFyfdzjanjQjrpPimYBSPT4j4JttwGSav6i+6PWEK+5kS
        avOsisqMZPP9/TgaUaR39/tnWBqrp4HnA68nZ7Gg7dzyEZtjBc/mnZOXXxbZyGrg
        ==
X-ME-Sender: <xms:eZOVXJrSW-1LMmNcf6MPRiabjWOXQT6kjQ9z_FxgtVh28Ue4DjDTwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjedvgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeimdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofer
    vdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsih
    hnrdgttgeqnecukfhppeduvdegrddujedurdefuddrudehudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:eZOVXA1Px3H7sM2oCQOYCrHxiH_juFPG9S5_CV7eb4z1cvtw35M1Rg>
    <xmx:eZOVXJneSMijiMc9z-fITr-JZ6BTNzFCFhgDSrs_fjbnXWV1EIvcHw>
    <xmx:eZOVXEZ8LkCq1rk7hwYi9M6TG047wWLh744N7w-dH8SmkWZlEC0TXQ>
    <xmx:eZOVXF5wIMkFri4zEjWBOhCOYOuqD9ovuqW1DVrIM_i9qEJMQq_1dw>
Received: from localhost (124-171-31-151.dyn.iinet.net.au [124.171.31.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40EEE100E5;
        Fri, 22 Mar 2019 22:01:28 -0400 (EDT)
Date:   Sat, 23 Mar 2019 13:01:03 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v5 2/2] checkpatch: Warn on improper usage of
 Co-developed-by
Message-ID: <20190323020103.GB17709@eros.localdomain>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
 <20190322211137.18241-3-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322211137.18241-3-sean.j.christopherson@intel.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:11:37PM -0700, Sean Christopherson wrote:
> The purpose of Co-developed-by: is to give attribution to authors who
> aren't already attributed by the From: tag, i.e. who aren't the nominal
> patch author.  Because Co-developed-by: is essentially a variation of
> From:, it must be accompanied by a Signed-off-by: of the associated
> co-author.  To ease the burden of determining whether or not co-authors
> have signed off, Co-developed-by and Signed-off-by: must be explicitly
> paired, i.e. on consecutive lines for a given co-author.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5b756278df13..bbe71f017f6d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2687,6 +2687,24 @@ sub process {
>  			} else {
>  				$signatures{$sig_nospace} = 1;
>  			}
> +
> +# Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
> +			if ($sign_off =~ /^co-developed-by:$/i) {
> +				if ($email eq $author) {
> +					WARN("BAD_SIGN_OFF",
> +					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
> +				}
> +				if (!defined $lines[$linenr]) {
> +					WARN("BAD_SIGN_OFF",
> +                                             "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
> +				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
> +					WARN("BAD_SIGN_OFF",
> +					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> +				} elsif ($1 ne $email) {
> +					WARN("BAD_SIGN_OFF",
> +					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> +				}
> +			}
>  		}
>  
>  # Check email subject for common tools that don't need to be mentioned
> -- 
> 2.21.0
> 


Works as advertised!

thanks,
Tobin.
