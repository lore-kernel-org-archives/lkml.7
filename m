Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFFFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120592077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd78jAWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfLKGlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 01:41:55 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:39167 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfLKGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:41:54 -0500
Received: by mail-il1-f169.google.com with SMTP id n1so3933546ilm.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrGa7PswnF5N73AOviLieAYQParN9bSIKpPibdITRLQ=;
        b=Bd78jAWkV3x6C+bxIH04IV+lCcew+/HyLagKxwfIlwXR5Tp5McQj2nAiFJUF79lJEg
         VZmsOsBEswBe1eUTQpMcXu0JkkAROIca4cwkf95nEccxz2Y+HGQ3l01D+YVAmcgbhOAk
         o+7AuFU+BDGDIuIgG6E1dHabA/Gpo6DLexyKot5Rs9OttFoUeGp7RKOeY1retc6qdQJx
         lFzzzifVPZ21Dcogz6xvCPqI3Qq2KTV5ipbpJddp6vLyUDBAIGYWN2ezOe3H+UzqTlKM
         nqYwAOsIF1YaPjJStdlpE9yJCmgr8pDt7xMp+s2VKnsDFj/lVCj6Q7+3J8Uk6IU3Qqsy
         X4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrGa7PswnF5N73AOviLieAYQParN9bSIKpPibdITRLQ=;
        b=JRkQpO/mSmwMd3zxcn4pNxxBn9GFW9DQaYrTMHhIPpCwJSXNkmiO9u65gJF9AKKguM
         bpvffkhnidGNt3D9GABkjCaq0GvCOuT4WxEC67x8t6etOp2qO+TYDXtg9UCBBjL625aV
         tlduJNkoov7JYAcBP2W4Tb7OFRN8Uzp19NWDuc4V4OiJzVV6OVJe5I1K29UuzIhhtHFD
         uw2Fz0znBju9F7Y1nkmlDermCo5nIBZv/WlDNhXUEYyyj4zplMhbccnhupAcSCgUJazZ
         Da9wXz4L0VahSQM7cRaVY279oyhrcPxAh2qp6/+HonIg8s7TwbxTfQBWP1FqjxvQPMwE
         orQw==
X-Gm-Message-State: APjAAAWz5evyenu5TRY+NHdf6/SKp+SRVyswi15kxiFUe2pyspLwuhmY
        VG3GMxN8hm/weJndKCl0oNtnX7ptp3P67QkXaT8=
X-Google-Smtp-Source: APXvYqxB5xrHmBsl3oYPY0W4Y+VVTfRuEADmz6s1MbKOtScpY3baGQ8SKP6PhogsC4CwPLLP7dHDxQwLfzLuIkKKS3I=
X-Received: by 2002:a92:d185:: with SMTP id z5mr1620043ilz.132.1576046513910;
 Tue, 10 Dec 2019 22:41:53 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
 <4f3e350d0fcef89e25350f7d68ea96f33dc4e3f0.camel@perches.com>
In-Reply-To: <4f3e350d0fcef89e25350f7d68ea96f33dc4e3f0.camel@perches.com>
From:   Vegard Nossum <vegard.nossum@gmail.com>
Date:   Wed, 11 Dec 2019 07:41:34 +0100
Message-ID: <CAOMGZ=FhJjQcv-49gQyAYkXW1LhtYcgis8rKASMo_dDKQ+dMkw@mail.gmail.com>
Subject: Re: get_maintainer.pl produces non-deterministic results
To:     Joe Perches <joe@perches.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 at 01:02, Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-12-10 at 14:47 +0100, Dmitry Vyukov wrote:
> > Hi Joe,
> >
> > scripts/get_maintainer.pl fs/proc/task_mmu.c
> > non-deterministically gives me from 13 to 16 results, different number
> > every time (on upstream 6794862a). Perl v5.28.1. Michael confirmed
> > this with v5.28.2.
> > Vergard suggested to check PERL_HASH_SEED=0. Indeed it fixes
> > non-determinism. But I guess it's not the right solution, there should
> > be some logical problem.
> > My perl-fo is weak, I appreciate if somebody with proper perl-fo takes a look.
> >
> > Thanks
>
> https://lkml.org/lkml/2017/7/13/789

Right, so you can make it reproducible if you add a tie-break to the sorting:

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 34085d146fa2c..109d9fb134dad 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -2179,7 +2179,7 @@ sub vcs_assign {
     $hash{$_}++ for @lines;

     # sort -rn
-    foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
+    foreach my $line (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
        my $sign_offs = $hash{$line};
        my $percent = $sign_offs * 100 / $divisor;

This would actually favour names that start with early letters (A, B,
...) over late letters (..., Y, Z), which might also be a bad thing. I
think to fix that you could include everybody who has the same number
of signoffs at the cutoff:

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 34085d146fa2c..80d3ed2ee6d70 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -2179,7 +2179,8 @@ sub vcs_assign {
     $hash{$_}++ for @lines;

     # sort -rn
-    foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
+    my $prev_sign_offs = -1;
+    foreach my $line (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
        my $sign_offs = $hash{$line};
        my $percent = $sign_offs * 100 / $divisor;

@@ -2187,7 +2188,7 @@ sub vcs_assign {
        next if (ignore_email_address($line));
        $count++;
        last if ($sign_offs < $email_git_min_signatures ||
-                $count > $email_git_max_maintainers ||
+                ($prev_sign_offs != $sign_offs && $count >
$email_git_max_maintainers) ||
                 $percent < $email_git_min_percent);
        push_email_address($line, '');
        if ($output_rolestats) {
@@ -2196,6 +2197,8 @@ sub vcs_assign {
        } else {
            add_role($line, $role);
        }
+
+       $prev_sign_offs = $sign_offs;
     }
 }

These patches are probably horribly whitespace damaged, hopefully you
get the gist of it though...


Vegard
