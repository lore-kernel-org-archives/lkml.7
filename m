Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E99C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08752208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJJOeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:34:05 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:46466 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbfJJOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:34:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F416E182CF668;
        Thu, 10 Oct 2019 14:34:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste18_623714dd4446
X-Filterd-Recvd-Size: 5143
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 14:34:02 +0000 (UTC)
Message-ID: <9b331c1184aca8a32b9132d29957cd5e8bef1c1d.camel@perches.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
From:   Joe Perches <joe@perches.com>
To:     dsterba@suse.cz, Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Oct 2019 07:34:01 -0700
In-Reply-To: <20191010142733.GT2751@twin.jikos.cz>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
         <20191009110943.7ff3a08a@gandalf.local.home>
         <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
         <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
         <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
         <20191010142733.GT2751@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 16:27 +0200, David Sterba wrote:
> On Wed, Oct 09, 2019 at 10:33:45AM -0700, Nick Desaulniers wrote:
> > On Wed, Oct 9, 2019 at 9:38 AM Joe Perches <joe@perches.com> wrote:
> > > I believe __must_check is best placed before the return type as
> > > that makes grep for function return type easier to parse.
> > > 
> > > i.e. prefer
> > >         [static inline] __must_check <type> <function>(<args...>);
> > > over
> > >         [static inline] <type> __must_check <function>(<args...>);
> > > 
> > 
> > + Miguel
> > So I just checked `__cold`, and `__cold` is all over the board in
> > style.  I see it:
> > 1. before anything fs/btrfs/super.c#L101
> > 2. after static before return type (what you recommend) fs/btrfs/super.c#L2318
> > 3. after return type fs/btrfs/inode.c#L9426
> 
> As you can see in the git history, case 1 is from 2015 and the newer
> changes put the attribute between type and name - that's my "current"
> but hopefully final preference.
> 
> > Can we pick a style and enforce it via checkpatch? (It's probably not
> > fun to check for each function attribute in
> > include/linux/compiler_attributes.h).
> 
> Anything that has the return type, attributes and function name on one
> line works for me, but I know that there are other style preferences
> that put function name as the first word on a separate line.  My reasons
> are for better search results, ie.
> 
>   extent_map.c:void __cold extent_map_exit(void)
>   extent_map.h:void __cold extent_map_exit(void);
>   file.c:void __cold btrfs_auto_defrag_exit(void)
>   inode.c:void __cold btrfs_destroy_cachep(void)
>   ordered-data.c:void __cold ordered_data_exit(void)
>   ordered-data.h:void __cold ordered_data_exit(void);
> 
> is better than
> 
>   send.c:__cold
>   super.c:__cold
>   super.c:__cold
>   super.c:__cold
> 
> which I might get to fix eventually.

When your examples have no function arguments, line
length isn't much of an issue. But most functions
take arguments and line length might matter there.

Here's a possible checkpatch test for location of
various __<attributes> that are not particularly
standardized.

---
 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cf7543a9d1b2..ed7e6319e061 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -390,6 +390,19 @@ our $Attribute	= qr{
 			____cacheline_internodealigned_in_smp|
 			__weak
 		  }x;
+
+our $PositionalAttribute	= qr{
+			__must_check|
+			__printf|
+			__scanf|
+			__pure|
+			__cold|
+			__hot|
+			__visible|
+			__weak|
+			noinline
+		}x;
+
 our $Modifier;
 our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};
 our $Member	= qr{->$Ident|\.$Ident|\[[^]]*\]};
@@ -3773,6 +3786,17 @@ sub process {
 			     "Avoid multiple line dereference - prefer '$ref'\n" . $hereprev);
 		}
 
+# check for declarations like __must_check ($PositionalAttribute) after the type
+		if ($line =~ /\b($Declare)\s+($PositionalAttribute)\b/) {
+			if (WARN("ATTRIBUTE_POSITION",
+				 "Prefer position of attribute '$2' before '$1'\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s@\b($Declare)(\s+)($PositionalAttribute)\b@$3$2$1@;
+				# 'static void noinline' becomes 'noinline static void', so fix noinline position if necessary
+				$fixed[$fixlinenr] =~ s@\bnoinline(\s+)static\b@static${1}noinline@;
+			}
+		}
+
 # check for declarations of signed or unsigned without int
 		while ($line =~ m{\b($Declare)\s*(?!char\b|short\b|int\b|long\b)\s*($Ident)?\s*[=,;\[\)\(]}g) {
 			my $type = $1;


