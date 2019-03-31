Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D12085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 23:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfCaXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:09:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41879 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731324AbfCaXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 19:09:48 -0400
Received: from callcc.thunk.org ([70.42.157.37])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x2VN9e27016916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Mar 2019 19:09:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 86446421A03; Sun, 31 Mar 2019 19:09:40 -0400 (EDT)
Date:   Sun, 31 Mar 2019 19:09:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: How to add Unicode character tables to the kernel?
Message-ID: <20190331230940.GA30957@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm currently looking to integrate Unicode case-folding and
normalization support into ext4.  In order to do this, we need to
include some Unicode table data into the kernel sources.  Per your
suggestion, the plan is to put them in fs/unicode and not fs/nls.

The question is how to do this, with different tradeoffs.  One is to
simply include a utf8data.h file, which will be 320k.  That might
sound large, but in fs/nls there are 3544k worth of similar files.
Some are relatively small --- only 16k.  But others are quite large
--- 480k to 856k.  The table for Chinese character set is such an
example.  So in comparison, the 320k size of utf8data.h is quite
compact.

The problem with this solution is that the files in fs/nls, and the
proposed utf8data.h, are generated files.  For example:

/*
 * linux/fs/nls/nls_cp850.c
 *
 * Charset cp850 translation tables.
 * Generated automatically from the Unicode and charset
 * tables from the Unicode Organization (www.unicode.org).
 * The Unicode to charset table has only exact mappings.
 */
	....
static const wchar_t charset2uni[256] = {
	/* 0x00*/
	0x0000, 0x0001, 0x0002, 0x0003,
	0x0004, 0x0005, 0x0006, 0x0007,
	....

Now, one could argue that these tables are not the preferred form of
modification, per the definition in the GPL.  So alternatively we
could include the underlying Unicode data files from unicode.org, and
a program that generates utf8data.h from those data files.  The
downside of this approach is that it will increase the size of the
kernel tree by over 5 megabytes:

<tytso@lambda> {/usr/projects/linux/ext4}   (unicode)
1395% ls fs/unicode/ucd
total 5544
  84 CaseFolding-11.0.0.txt	          4 NormalizationCorrections-11.0.0.txt
 112 DerivedAge-11.0.0.txt	       2492 NormalizationTest-11.0.0.txt
 160 DerivedCombiningClass-11.0.0.txt     4 README
 960 DerivedCoreProperties-11.0.0.txt  1728 UnicodeData-11.0.0.txt

Generation of the utf8data.h is fast; so this is basically a disk
space question.  The files *are* compressible; and if we compressed
them all, it would be about 932k.  This won't help the increase in the
size of the git pack files, and we'll still need to decompress the
files when building the kernel, so some might still not be excited
about this.

So Linus, do you have a preference between:

* Just drop the 320k utf8data.h file into fs/unicode.  The file is
  basically much like the fils in fs/nls, so there is precedence for
  this.  Similarly, the files in lib/font are also data files, and
  we've historically not been worried about whether or not this would
  cause objections from people who would argue that these are not the
  "preferred form of modification".  Of course, I very much doubt
  anyone has ever *wanted* to modify these files, but....

* Drop the uncompressed 5544k worth of fs/unicode/ucd/*.txt files into
  the kernel sources.

* Drop the compressed fs/unicode/ucd/*.txt.gz into the kernl sources.
  This will increase the kernel sources by 932k.

If we go down the first path, we will include the progam to generate
the utf8data.h, and instructions for how to download the
fs/unicode/ucd/*.txt from unicode.org.  I don't forsee any kernel
developers actually wanting to modify these files, since if we do this
we break compatibility with everyone else using Unicode.  The only
reason to include them is people who are nit-picky with respect to the
GPL.

Personally, I don't care.  I just want direction of which path you
would prefer, since I predict that no matter which path gets chosen,
there will be some people who will be kvetching and registering
objections.

Thanks,

					- Ted
