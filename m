Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098E6C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AD1229F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564024031;
	bh=/apw49bWmNuKTrcGODkK1kactakYqDoawBq5nGk1lNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jXL9Ke+evB5slEAXny2Ez3S6znXgHa0qkfp0D4+baqRb6Ydxk4e6adv9jSo09lwBL
	 orNfKPhofYB84yh8vRmWF4sv3drPMPbLtb0W128pEXQamjMB0G6I+JBizA7HIbj7Rk
	 XSyv5+KSQcQmh3cKTuiGcw6vs2Wb6yKK/UDiMGFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbfGYDHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389615AbfGYDHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:07:10 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62EF229F4;
        Thu, 25 Jul 2019 03:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564024029;
        bh=/apw49bWmNuKTrcGODkK1kactakYqDoawBq5nGk1lNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HNkSvjs08KMthGYe0CfiWbB9/kL2fb/OLHPJtnHC4wI+1e63pCUourQqnB9LaiDgQ
         IEMp2OQLzuScBVmusxBDYXnkLBOmix4t2EjScB2i40w1xvj/xcEtWvvmx6uOnfBbJk
         OArmoWhGs2r7XvvaeLDcTjUpanFtaZK67ZugOIbM=
Date:   Wed, 24 Jul 2019 20:07:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2] checkpatch.pl: warn on invalid commit id
Message-Id: <20190724200707.2ba88e3affd73de1ce64fab6@linux-foundation.org>
In-Reply-To: <20190711001640.13398-1-mcroce@redhat.com>
References: <20190711001640.13398-1-mcroce@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019 02:16:40 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> It can happen that a commit message refers to an invalid commit id, because
> the referenced hash changed following a rebase, or simply by mistake.
> Add a check in checkpatch.pl which checks that an hash referenced by
> a Fixes tag, or just cited in the commit message, is a valid commit id.
> 
>     $ scripts/checkpatch.pl <<'EOF'
>     Subject: [PATCH] test commit
> 
>     Sample test commit to test checkpatch.pl
>     Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") really exists,
>     commit 0bba044c4ce7 ("tree") is valid but not a commit,
>     while commit b4cc0b1c0cca ("unknown") is invalid.
> 
>     Fixes: f0cacc14cade ("unknown")
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>     EOF
>     WARNING: Unknown commit id '0bba044c4ce7', maybe rebased or not pulled?
>     #8:
>     commit 0bba044c4ce7 ("tree") is valid but not a commit,
> 
>     WARNING: Unknown commit id 'b4cc0b1c0cca', maybe rebased or not pulled?
>     #9:
>     while commit b4cc0b1c0cca ("unknown") is invalid.
> 
>     WARNING: Unknown commit id 'f0cacc14cade', maybe rebased or not pulled?
>     #11:
>     Fixes: f0cacc14cade ("unknown")
> 
>     total: 0 errors, 3 warnings, 4 lines checked
> 
> ...
>
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2898,6 +2898,17 @@ sub process {
>  			}
>  		}
>  
> +# check for invalid commit id
> +		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
> +			my $id;
> +			my $description;
> +			($id, $description) = git_commit_info($2, undef, undef);
> +			if (!defined($id)) {
> +				WARN("UNKNOWN_COMMIT_ID",
> +				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
> +			}
> +		}
> +

What does it do if we're not operating in a git directory? For example,
I work in /usr/src/25 and my git repo is in ../git26.

Also, what happens relatively often is that someone quotes a linux-next
or long-term-stable hash.  If the user has those trees in the git repo,
I assume they won't be informed of the inappropriate hash?

