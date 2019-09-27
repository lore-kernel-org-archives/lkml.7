Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF42C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CB620863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nphyvAmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfI0FG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:06:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34406 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfI0FG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:06:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so840940pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gmthhdO8i8YzAo8qsmW2C157vnOgxWk2DkxBpuFm+3U=;
        b=nphyvAmILeYXnOu0afi9B/klyectMrtxcrD3Hz6Vrkvvz/dmfZHNDhfsRenDOYr4ec
         j+31eJIiNm70CstDLuD7eLp5yLwVd4PH/1d2nIj9c2kOB0MC3QN/Fc0stS3olqf1wq7n
         1q2RfqoamBxRp7867wH2B0JECCWp0879wpKvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmthhdO8i8YzAo8qsmW2C157vnOgxWk2DkxBpuFm+3U=;
        b=B5O8duVsqXcsZ+9n58LqquHqQAAthYNPr2NYtSIBtshP1ApPNHYyWvGXKKyV5N0TdV
         cHs1D7GjomA2Ds8A5gWiL2OqIstBzNaBScHg9/ZMONfRAnyUOFWewo+j+pQp0kUVLTFr
         RuHCY7Kwb+CT5jZUZ2EYLiKGMCtx8paLv4kkobqy751EKXHle/YIRBhD7LaUervA1r+j
         yQb0Jz/7nd3uCEUEcgo2rycG3L+WVCOZatM7BH3rqS/udBQsKOhZ8ZWT+zhxI4vRL3J6
         5f+sr4FG8svine2UznYzuu+AD9BYmns5+sRcEVOvm6jjwsBuvm1rTNSbrHmk4rdUoxBv
         Vy+A==
X-Gm-Message-State: APjAAAUFIyLQEHdMWPm+H/fX/pvRHo1vZY9KePXBjz0l34I7rkzqhpPX
        FToVdmicQ0DpjIR5agJJ+JuLrQ==
X-Google-Smtp-Source: APXvYqxomaa9+MP71Ya7IxN8ToS7XZRCuPg0KBkQB6PFtaZzWv6iwa13EU4+25hTZqAMThds9R8dlg==
X-Received: by 2002:a17:90b:d91:: with SMTP id bg17mr7631357pjb.79.1569560786104;
        Thu, 26 Sep 2019 22:06:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p88sm3867131pjp.22.2019.09.26.22.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 22:06:25 -0700 (PDT)
Date:   Thu, 26 Sep 2019 22:06:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] get_maintainer: Add signatures from Fixes: <badcommit>
 lines in commit message
Message-ID: <201909262205.EEFAF1CA4@keescook>
References: <33605b9fc0e0f711236951ae84185a6218acff4f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33605b9fc0e0f711236951ae84185a6218acff4f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 09:46:34PM -0700, Joe Perches wrote:
> Fixes: lines in a commit message generally indicate that a
> previous commit was inadequate for whatever reason.
> 
> The signers of the previous inadequate commit should also be
> cc'd on this new commit so update get_maintainer to find the
> old commit and add the original signers.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Joe Perches <joe@perches.com>

I wanted to have this feature today, even. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/get_maintainer.pl | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 5ef59214c555..34085d146fa2 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -26,6 +26,7 @@ my $email = 1;
>  my $email_usename = 1;
>  my $email_maintainer = 1;
>  my $email_reviewer = 1;
> +my $email_fixes = 1;
>  my $email_list = 1;
>  my $email_moderated_list = 1;
>  my $email_subscriber_list = 0;
> @@ -249,6 +250,7 @@ if (!GetOptions(
>  		'r!' => \$email_reviewer,
>  		'n!' => \$email_usename,
>  		'l!' => \$email_list,
> +		'fixes!' => \$email_fixes,
>  		'moderated!' => \$email_moderated_list,
>  		's!' => \$email_subscriber_list,
>  		'multiline!' => \$output_multiline,
> @@ -503,6 +505,7 @@ sub read_mailmap {
>  ## use the filenames on the command line or find the filenames in the patchfiles
>  
>  my @files = ();
> +my @fixes = ();			# If a patch description includes Fixes: lines
>  my @range = ();
>  my @keyword_tvi = ();
>  my @file_emails = ();
> @@ -568,6 +571,8 @@ foreach my $file (@ARGV) {
>  		my $filename2 = $2;
>  		push(@files, $filename1);
>  		push(@files, $filename2);
> +	    } elsif (m/^Fixes:\s+([0-9a-fA-F]{6,40})/) {
> +		push(@fixes, $1) if ($email_fixes);
>  	    } elsif (m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/) {
>  		my $filename = $1;
>  		$filename =~ s@^[^/]*/@@;
> @@ -598,6 +603,7 @@ foreach my $file (@ARGV) {
>  }
>  
>  @file_emails = uniq(@file_emails);
> +@fixes = uniq(@fixes);
>  
>  my %email_hash_name;
>  my %email_hash_address;
> @@ -612,7 +618,6 @@ my %deduplicate_name_hash = ();
>  my %deduplicate_address_hash = ();
>  
>  my @maintainers = get_maintainers();
> -
>  if (@maintainers) {
>      @maintainers = merge_email(@maintainers);
>      output(@maintainers);
> @@ -927,6 +932,10 @@ sub get_maintainers {
>  	}
>      }
>  
> +    foreach my $fix (@fixes) {
> +	vcs_add_commit_signers($fix, "blamed_fixes");
> +    }
> +
>      foreach my $email (@email_to, @list_to) {
>  	$email->[0] = deduplicate_email($email->[0]);
>      }
> @@ -1031,6 +1040,7 @@ MAINTAINER field selection options:
>      --roles => show roles (status:subsystem, git-signer, list, etc...)
>      --rolestats => show roles and statistics (commits/total_commits, %)
>      --file-emails => add email addresses found in -f file (default: 0 (off))
> +    --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))
>    --scm => print SCM tree(s) if any
>    --status => print status if any
>    --subsystem => print subsystem name if any
> @@ -1730,6 +1740,32 @@ sub vcs_is_hg {
>      return $vcs_used == 2;
>  }
>  
> +sub vcs_add_commit_signers {
> +    return if (!vcs_exists());
> +
> +    my ($commit, $desc) = @_;
> +    my $commit_count = 0;
> +    my $commit_authors_ref;
> +    my $commit_signers_ref;
> +    my $stats_ref;
> +    my @commit_authors = ();
> +    my @commit_signers = ();
> +    my $cmd;
> +
> +    $cmd = $VCS_cmds{"find_commit_signers_cmd"};
> +    $cmd =~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
> +
> +    ($commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref) = vcs_find_signers($cmd, "");
> +    @commit_authors = @{$commit_authors_ref} if defined $commit_authors_ref;
> +    @commit_signers = @{$commit_signers_ref} if defined $commit_signers_ref;
> +
> +    foreach my $signer (@commit_signers) {
> +	$signer = deduplicate_email($signer);
> +    }
> +
> +    vcs_assign($desc, 1, @commit_signers);
> +}
> +
>  sub interactive_get_maintainers {
>      my ($list_ref) = @_;
>      my @list = @$list_ref;
> 
> 

-- 
Kees Cook
