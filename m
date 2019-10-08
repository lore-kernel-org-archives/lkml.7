Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3C9C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD462206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJHRCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:02:36 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:58781 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfJHRCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:02:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3675D180A812A;
        Tue,  8 Oct 2019 17:02:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: play60_164c175f4454d
X-Filterd-Recvd-Size: 3821
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 17:02:33 +0000 (UTC)
Message-ID: <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Oct 2019 10:02:31 -0700
In-Reply-To: <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 17:28 +0200, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Tue, Oct 8, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> > > When reading a patch file from standard input, checkpatch calls it "Your
> > > patch", and reports its state as:
> > > 
> > >     Your patch has style problems, please review.
> > > 
> > > or:
> > > 
> > >     Your patch has no obvious style problems and is ready for submission.
> > > 
> > > Hence when checking multiple patches by piping them to checkpatch, e.g.
> > > when checking patchwork bundles using:
> > > 
> > >     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> > > 
> > > it is difficult to identify which patches need to be reviewed and
> > > improved.
> > > 
> > > Fix this by replacing "Your patch" by the patch subject, if present.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> > >       }
> > >       while (<$FILE>) {
> > >               chomp;
> > > +             if ($vname eq 'Your patch') {
> > > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > +                     $vname = '"' . $subject . '"' if $subject;
> > 
> > Hi again Geert.
> > 
> > Just some stylistic nits:
> > 
> > $filename is not quoted so I think adding quotes
> > before and after $subject may not be useful.
> 
> Filename is indeed not quoted, but $git_commits{$filename} is.

If I understand your use case, this will only show the last
patch $subject of a bundle?

Also, it'll show things like "duplicate signature" when multiple
patches are tested in a single bundle.

For instance, if I have a git format-patch series in an output
directory and do

$ cat <output_dir>/*.patch | ./scripts/checkpatch.pl

Bad output happen.

Maybe this might be better:

---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cf7543a9d1b2..2f79c585e795 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2444,6 +2444,15 @@ sub process {
 
 		my $rawline = $rawlines[$linenr - 1];
 
+# if input from stdin, report the subject lines if they exist
+		if ($filename eq '-' && !$quiet &&
+		    $rawline =~ /^Subject:\s*(.*)/) {
+			report("stdin", "STDIN", '-' x length($1));
+			report("stdin", "STDIN", $1);
+			report("stdin", "STDIN", '-' x length($1));
+			%signatures = ();	# avoid duplicate signatures
+		}
+
 # check if it's a mode change, rename or start of a patch
 		if (!$in_commit_log &&
 		    ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||

