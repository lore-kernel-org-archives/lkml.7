Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4330721900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="lKcgAYoU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enUTaN3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCUXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:41:58 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34945 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbfCUXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:41:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F8B022336;
        Thu, 21 Mar 2019 19:41:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Mar 2019 19:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=isd8Fz4FKjgCWUwIYS11ZkJgQAF
        kSWWP2WcYJgr79cA=; b=lKcgAYoUaQB2Z1ZiycHGL3FfhQB4g+I9DM1QFBVnTnR
        amA9bMhFI8frUVPFDyiE+FrLE7U6h2aZYwzkzu+ASpCG1uYje57ZUBGAN8TdQMN4
        6GAAimN9Ikixwyv9iBgsO7aweX/ikn0h6q7zJkUX1l5bg40EFrnkrCg1axRlp8NK
        ZDCv8MUhgXJaCejLgPw1exToZXUZHyuUlLrsP4K2p41V0Gd9LGOoWvb/qjxutTdo
        zX2yO4NBdxd81vjZX/Rr0P1zetpoLq1AdHFXXicLTUvrqct6Zq3iG425GBo9Q/Bn
        rrSqgMCYNRZsceyQYcWDwW+P1zSa/9YLlLgCemlxz/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=isd8Fz
        4FKjgCWUwIYS11ZkJgQAFkSWWP2WcYJgr79cA=; b=enUTaN3HpzFFdxYdcHQpsl
        vhAfIXCqwEN3b2dsUvNBc+ZI8TMQ7WdnC5L2++y21bSNLgPb3VQ+Bgk9kSH9DecQ
        iJYl7Ey0vNoiSGkZp4ZjNW9wqazo86cGw5uo3G+PKH63avVkxGmL9RWzkrRfzXUT
        xNgIZX9B+8QhAv78/FbCUlBgl6MPUzeJ2rAZut1BSxUVLonulClEjwxMgQxaESQm
        ABR45ttR/D82rNY3wnu22qFSWD0cShndizO1sWc90AF59GExY09/HyEAb4srfvpT
        tHvGIj//nD5fCDmumrb0DggIaw18kQW2HdCIVoSztBKdmKVO3eEG9+FTdpxL1PLQ
        ==
X-ME-Sender: <xms:QyGUXB2qSijk4jvskDh2AiolJb-unCqQzYB2gVDNn7MRwJSHs9NQ6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeimdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofer
    vdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsih
    hnrdgttgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvgedrudej
    uddrfedurdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtg
    gtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QyGUXJWYtrBuaPZY1C6qE9o0x9gac4AU6xWEVFHF8RMBe4DXx6LqPA>
    <xmx:QyGUXKXZ-Ky7oRKuUuFgyh5ilmNtJZLjwOE5plje9dudc4SmsHY8BQ>
    <xmx:QyGUXFD6C0agntPFEeM5GmOPn_L21l3Bi6oWhTWGd_8dcv1GckmxoQ>
    <xmx:RCGUXGLtMHn-b6D2wED3Nh7rZwQOxgr4g6p8UGqOnKWl5woDl5z-JQ>
Received: from localhost (124-171-31-151.dyn.iinet.net.au [124.171.31.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA871E49DC;
        Thu, 21 Mar 2019 19:41:54 -0400 (EDT)
Date:   Fri, 22 Mar 2019 10:41:25 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v3] docs: Clarify the usage and sign-off requirements for
 Co-developed-by
Message-ID: <20190321234125.GB17705@eros.localdomain>
References: <20190321200103.9333-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321200103.9333-1-sean.j.christopherson@intel.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Thanks for working on this, I have been struggling to correctly use (and
get the co-author to SOB) the Co-developed-by tag :)

On Thu, Mar 21, 2019 at 01:01:03PM -0700, Sean Christopherson wrote:
> The documentation for Co-developed-by is a bit light on details, e.g. it
> doesn't explicitly state that:
> 
>   - Multiple Co-developed-by tags are perfectly acceptable
>   - Co-developed-by and Signed-off-by must be paired together
>   - SOB ordering should still follow standard sign-off procedure
> 
> Lack of explicit direciton has resulted in developers taking a variety
> of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
> willy-nilly, collecting them all at the end or the beginning, etc...
> 
> Tweak the wording to make it clear that multiple co-authors are allowed,
> and document the expectation that standard sign-off procedures are to
> be followed.  Provide examples to (hopefully) eliminate any ambiguity.
> 
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
> 
> v1: https://lkml.kernel.org/r/20190320151140.32432-1-sean.j.christopherson@intel.com
> v2: https://lkml.kernel.org/r/20190321184316.8525-1-sean.j.christopherson@intel.com
>     Rewrite the blurb to state standard sign-off procedure should be
>     followed as opposed to dictating the original author's SOB be last.
> v3: Update a similar blurb in Documentation/process/5.Posting.rst
> 
>  Documentation/process/5.Posting.rst          |  8 +++----
>  Documentation/process/submitting-patches.rst | 24 +++++++++++++++++---
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 4213e580f273..c8cac58f0f93 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -216,10 +216,10 @@ The tags in common use are:
>     which can be found in :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>     Code without a proper signoff cannot be merged into the mainline.
>  
> - - Co-developed-by: states that the patch was also created by another developer
> -   along with the original author.  This is useful at times when multiple
> -   people work on a single patch.  Note, this person also needs to have a
> -   Signed-off-by: line in the patch as well.
> + - Co-developed-by: states that the patch was co-created by other developer(s)
> +   along with the original author.  Every Co-developed-by: must be accompanied
> +   by a Signed-off-by: of the co-author.  Details and examples can be found in
> +   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
>  
>   - Acked-by: indicates an agreement by another developer (often a
>     maintainer of the relevant code) that the patch is appropriate for
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be7d1829c3af..a7a9da68a384 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -545,10 +545,28 @@ person it names - but it should indicate that this person was copied on the
>  patch.  This tag documents that potentially interested parties
>  have been included in the discussion.
>  
> -A Co-developed-by: states that the patch was also created by another developer
> +A Co-developed-by: states that the patch was co-created by other developer(s)
>  along with the original author.  This is useful at times when multiple people
> -work on a single patch.  Note, this person also needs to have a Signed-off-by:
> -line in the patch as well.
> +work on a single patch.  Every Co-developed-by: must be immediately followed by
> +a Signed-off-by: of the co-author.  Standard sign-off procedure applies, i.e.
> +the ordering of Co-developed-by:/Signed-off-by: pairs should reflect the
> +chronological history of the patch insofar as possible.  Notably, the last
> +Signed-off-by: must always be that of the developer submitting the patch,
> +regardless of whether they are the original author or a co-author.
> +
> +Example of a patch with multiple co-authors, submitted by the original author::
> +
> +	Co-developed-by: First Co-Author <first@coauthor.example.org>
> +	Signed-off-by: First Co-Author <first@coauthor.example.org>
> +	Co-developed-by: Second Co-Author <second@coauthor.example.org>
> +	Signed-off-by: Second Co-Author <second@coauthor.example.org>
> +	Signed-off-by: Original Author <original@author.example.org>
> +
> +Example of a patch submitted by a co-author::
> +
> +	Signed-off-by: Original Author <original@author.example.org>
> +	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
> +	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>

As someone who has read the docs then tried with difficulty to use this
tag I think we should drop the term 'original' from describing any author.

The reason is that the two versions above do not explicitly show who is
the 'original' author.  This means the docs contain noise that makes the
tag harder to use.  All the tag shows is that one person is submitting a
patch (the last SOB and sender of the patch) AND someone else worked on
it (and agrees that they did).

FWIW we are trying to give attribution, right?  We don't need to
explicitly state who wrote what so I do not believe that 'original' is a
useful thing to be.  Linus 'originally' wrote Linux but that does not
say squat about the state of the code right now :)

thanks,
Tobin.
