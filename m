Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5DD218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="gtNauqUL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io+vk7uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCWCGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:06:33 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37403 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbfCWCGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:06:33 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 22:06:32 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DC4053955;
        Fri, 22 Mar 2019 22:00:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Mar 2019 22:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4EfGI/0wzNI8kKBOC6it2nlQqsW
        pMBHGWWdNm+9Im8E=; b=gtNauqULKVFRJMe/FCHUVVXBOZvbaC81/FO6dl0uAvN
        35ziNWqzJvZHT9GGr23Y7lyA83pUcXMlFugDOmYRoqgFoXREyB2mhoxGIoelEMSS
        6kxvV6jDeR4YkH9e1EVf8Jtdv8WvuidpN07H9QFDfwqmm/b6sP0iCyClCmK6hMNm
        CLcH0hg06HURwbeJ893iznWRhSmLqKXcpPlHxDvWSa9LUQOpAdl0DQ90lzOTbrVC
        Z2C/pVICvtBs3DEt5zgk89OsqoHX+yiWMtHsycreHo2xsDjtOgF3oTyAttmyDVrn
        53QfloADzyYjDa0EnvNx1tixupvmgHkiI6KrWzFXpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4EfGI/
        0wzNI8kKBOC6it2nlQqsWpMBHGWWdNm+9Im8E=; b=Io+vk7uy+V7O2knsFP7lkQ
        Hi3CsLDiFKRBdTNNu9Z1dwCm/Enk5474yNZ8kbieQmBLtDOBw9jx+h2dpC1xiu5J
        dnqqzKw+d7MGyQk3ftxhX5Fl1Qskb4GWdT8AtOMW7OJquc5ioZhGM7rAGCxIcPTt
        iqrsL1yQnZSUId28FXBXFHBdpel63/FwPnsCski1tnr+E0nxNWt6T8BY2IbPPJz0
        O3sjU+rgFc4QidHQCFQtr69qzL6x3IpqEVKnohKwijNYVLORYEumgTMi1E1d5AXP
        DMSwLGzCwVhkWroN4ZLi/P7CNGN9LdvggZWB40JmUUPuEvx5yIyyk0mG7wEYVm9w
        ==
X-ME-Sender: <xms:TZOVXErSQ47Ad1WXUA40jrcNwsbIAMSBXRKfBSANsGG69PhRDJzaBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjedvgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeimdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofer
    vdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsih
    hnrdgttgeqnecukfhppeduvdegrddujedurdefuddrudehudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:TZOVXK1iEYL2VIt-XuHQr0-yxFKp2FglsPfNNWlexso1ju0upm98Rw>
    <xmx:TZOVXCXq5tRynpOICaDRBhzqC-XqM5KRMQgDyEMe1x0eS5j0WldGNA>
    <xmx:TZOVXCb27vvk1Em87Z-pg_v72P9W8etvT0MlIphTyMnwvt4u-M4yDQ>
    <xmx:TpOVXCvc6kSXfIhAsTk9fCf-9NNw0mTjKIHYi_Xv7-_pZsfUiJ5_HA>
Received: from localhost (124-171-31-151.dyn.iinet.net.au [124.171.31.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C244E4519;
        Fri, 22 Mar 2019 22:00:44 -0400 (EDT)
Date:   Sat, 23 Mar 2019 13:00:18 +1100
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
Subject: Re: [PATCH v5 1/2] docs: Clarify the usage and sign-off requirements
 for Co-developed-by
Message-ID: <20190323020018.GA17709@eros.localdomain>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
 <20190322211137.18241-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322211137.18241-2-sean.j.christopherson@intel.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:11:36PM -0700, Sean Christopherson wrote:
> The documentation for Co-developed-by is a bit light on details, e.g. it
> doesn't explicitly state that:
> 
>   - Multiple Co-developed-by tags are perfectly acceptable
>   - Co-developed-by and Signed-off-by must be paired together
>   - SOB ordering should still follow standard sign-off procedure
> 
> Lack of explicit direction has resulted in developers taking a variety
> of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
> willy-nilly, collecting them all at the end or the beginning, etc...
> Tweak the wording to make it clear that multiple co-authors are allowed,
> and document the expectation that standard sign-off procedures are to
> be followed.
> 
> The use of "original author" has also led to confusion as many patches
> don't have just one "original" author, e.g. when multiple developers
> are involved from the genesis of the patch.  Remove all usage of
> "original" and instead call out that Co-developed-by is simply a way to
> provide attribution in addition to the From tag, i.e. neither tag is
> intended to imply anything with regard to who did what.
> 
> Provide examples to (hopefully) eliminate any ambiguity.
> 
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  Documentation/process/5.Posting.rst          | 10 +++--
>  Documentation/process/submitting-patches.rst | 40 +++++++++++++++++---
>  2 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 4213e580f273..855a70b80269 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -216,10 +216,12 @@ The tags in common use are:
>     which can be found in :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>     Code without a proper signoff cannot be merged into the mainline.
>  
> - - Co-developed-by: states that the patch was also created by another developer
> -   along with the original author.  This is useful at times when multiple
> -   people work on a single patch.  Note, this person also needs to have a
> -   Signed-off-by: line in the patch as well.
> + - Co-developed-by: states that the patch was co-created by several developers;
> +   it is a used to give attribution to co-authors (in addition to the author
> +   attributed by the From: tag) when multiple people work on a single patch.
> +   Every Co-developed-by: must be immediately followed by a Signed-off-by: of
> +   the associated co-author.  Details and examples can be found in
> +   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
>  
>   - Acked-by: indicates an agreement by another developer (often a
>     maintainer of the relevant code) that the patch is appropriate for
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be7d1829c3af..06db26b12495 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -545,10 +545,40 @@ person it names - but it should indicate that this person was copied on the
>  patch.  This tag documents that potentially interested parties
>  have been included in the discussion.
>  
> -A Co-developed-by: states that the patch was also created by another developer
> -along with the original author.  This is useful at times when multiple people
> -work on a single patch.  Note, this person also needs to have a Signed-off-by:
> -line in the patch as well.
> +Co-developed-by: states that the patch was co-created by multiple developers;
> +it is a used to give attribution to co-authors (in addition to the author
> +attributed by the From: tag) when several people work on a single patch.  Since
> +Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
> +followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> +procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
> +chronological history of the patch insofar as possible, regardless of whether
> +the author is attributed via From: or Co-developed-by:.  Notably, the last
> +Signed-off-by: must always be that of the developer submitting the patch.
> +
> +Note, the From: tag is optional when the From: author is also the person (and
> +email) listed in the From: line of the email header.
> +
> +Example of a patch submitted by the From: author::
> +
> +	<changelog>
> +
> +	Co-developed-by: First Co-Author <first@coauthor.example.org>
> +	Signed-off-by: First Co-Author <first@coauthor.example.org>
> +	Co-developed-by: Second Co-Author <second@coauthor.example.org>
> +	Signed-off-by: Second Co-Author <second@coauthor.example.org>
> +	Signed-off-by: From Author <from@author.example.org>
> +
> +Example of a patch submitted by a Co-developed-by: author::
> +
> +	From: From Author <from@author.example.org>
> +
> +	<changelog>
> +
> +	Co-developed-by: Random Co-Author <random@coauthor.example.org>
> +	Signed-off-by: Random Co-Author <random@coauthor.example.org>
> +	Signed-off-by: From Author <from@author.example.org>
> +	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
> +	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
>  
>  
>  13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
> @@ -696,7 +726,7 @@ A couple of example Subjects::
>  The ``from`` line must be the very first line in the message body,
>  and has the form:
>  
> -        From: Original Author <author@example.com>
> +        From: Patch Author <author@example.com>
>  
>  The ``from`` line specifies who will be credited as the author of the
>  patch in the permanent changelog.  If the ``from`` line is missing,
> -- 
> 2.21.0
> 

Crystal clear now, thanks.

	Tobin
