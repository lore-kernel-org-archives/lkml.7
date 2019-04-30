Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C4EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A71921670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="mwHJfqlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfD3SiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:38:09 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:31063 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:38:09 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 14:38:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4805; q=dns/txt; s=iport;
  t=1556649488; x=1557859088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ygGjUAq6julglQVpGIzo9b8DwlEEDtK2cO/Ew9Np6nk=;
  b=mwHJfqlG/fsFOYkD+MHjXSXjb9oxqT2Qc0dj6ow4IDyBlIcjr7/0djBL
   X1YvCGuo1COAmW8jreu2pVf/k61i3KqM3XWsK84ZMJM81tI3YYgy5F38f
   sGYZVdPPz1EhyOxL9w0EtQuPeycSE2JP636gllkjYsnssscmrL0BB+rli
   4=;
X-IronPort-AV: E=Sophos;i="5.60,414,1549929600"; 
   d="scan'208";a="264973989"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Apr 2019 18:31:03 +0000
Received: from bxb-ads-339.cisco.com (bxb-ads-339.cisco.com [161.44.92.172])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id x3UIV2RH004534;
        Tue, 30 Apr 2019 18:31:03 GMT
Received: by bxb-ads-339.cisco.com (Postfix, from userid 187872)
        id 11522100BFF8; Tue, 30 Apr 2019 14:31:02 -0400 (EDT)
From:   Yongkui Han <yonhan@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Yongkui Han <yonhan@cisco.com>
Subject: [PATCH] Brute-force binary-scanning method to extract certificates
Date:   Tue, 30 Apr 2019 14:30:26 -0400
Message-Id: <20190430183026.31982-1-yonhan@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 161.44.92.172, bxb-ads-339.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehmet, David,

I came up with an enhancement to the scripts/extract-sys-certs.pl script
in Linux kernel source, so that the system certificates can be extracted
without debugging symbols or System.map file.

The idea is that the DER-format kernel X509 certificate follows some fixed
pattern. So we can search this fixed pattern to find the location of the
system certificate.

Specifically, below is the pattern I used:

    ($type0, $len0, $type1, $len1, $ver_attr) =
        unpack "nnnnN", substr($fb, $start, 12);
    if ($type0 == 0x3082 && $type1 == 0x3082 && $ver_attr == 0xa0030201) {
        my $certsize = $len0 + 4;
        printf "Have %u bytes of certificate at file offset 0x%x\n",
               $certsize, $start;

That is, in the first 12 bytes, two 2-bytes must be 0x3082, and one 4-bytes
must be 0xa0030201. The length of the certificate is also in one of the
2-bytes of the first 12 bytes array.

The script works by scanning the vmlinux file to find this fixed pattern,
and extract the certificate. I think it can be optimized to only scan the
.init* section, instead of the whole vmlinux file. However, the current
approach seems already sufficient.

I have tested with different vmlinux files, and the script works well.

The new script output is like below:

[ bxb-ads-339 ] ./extract-sys-certs.pl  vmlinux  sys_cert.x509
Have 33 sections
No symbols available, will try brute-force approach.
Length of vmlinux is: 21354392
Have 1063 bytes of certificate at file offset 0x12f99b8
Have 1070 bytes of certificate at file offset 0x12f9ddf
Have 851 bytes of certificate at file offset 0x12fa20d
Have 1188 bytes of certificate at file offset 0x12fa560
Length of extracted certificate is: 4172
[ bxb-ads-339 ]

There is no change if vmlinux contains debugging symbols or System.map
file is provided.

Enclosed please find the git diff output. I can also send you the patch
with “git format-patch” and “git send-email” for you to review.

If possible, can you also try the enhanced script with a few kernel
vmlinux files to test it?

Your review/comments are greatly appreciated.

Thanks,
Yongkui

Signed-off-by: Yongkui Han <yonhan@cisco.com>
---
 scripts/extract-sys-certs.pl | 44 +++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/scripts/extract-sys-certs.pl b/scripts/extract-sys-certs.pl
index fa8ab15118cc..06f515b4dcd6 100755
--- a/scripts/extract-sys-certs.pl
+++ b/scripts/extract-sys-certs.pl
@@ -86,6 +86,44 @@ if ($nr_symbols == 0 && $sysmap ne "") {
     parse_symbols(@lines);
 }
 
+my $buf = "";
+my $len= 0;
+my $size = 0;
+
+if ($nr_symbols == 0 && $sysmap eq "") {
+    print "No symbols available, will try brute-force approach\n";
+
+    my $filesize = -s $vmlinux;
+    open FD, "<$vmlinux" || die $vmlinux;
+    binmode(FD);
+    my $fb;
+    my $len = sysread(FD, $fb, $filesize);
+    die "$vmlinux" if (!defined($len));
+    die "Short read on $vmlinux\n" if ($len != $filesize);
+    close(FD) || die $vmlinux;
+    printf "Length of vmlinux is: %d\n", length($fb);
+
+    my ($type0, $len0, $type1, $len1, $ver_attr) = (0,0,0,0,0);
+    my $start = 0;
+    while ($start < $filesize - 256) {
+        ($type0, $len0, $type1, $len1, $ver_attr) =
+            unpack "nnnnN", substr($fb, $start, 12);
+        if ($type0 == 0x3082 && $type1 == 0x3082 && $ver_attr == 0xa0030201) {
+            my $certsize = $len0 + 4;
+            printf "Have %u bytes of certificate at file offset 0x%x\n",
+                   $certsize, $start;
+            $buf .= substr($fb, $start, $certsize);
+            $start += $certsize;
+        } else {
+            $start += 1;
+        }
+    }
+
+    $size = length($buf);
+    printf "Length of extracted certificate is: %d\n", $size ;
+}
+else {
+
 die "No symbols available\n"
     if ($nr_symbols == 0);
 
@@ -97,7 +135,6 @@ die "Can't find system certificate list"
 
 my $start = Math::BigInt->new($symbols{"__cert_list_start"});
 my $end;
-my $size;
 my $size_sym = Math::BigInt->new($symbols{"system_certificate_list_size"});
 
 open FD, "<$vmlinux" || die $vmlinux;
@@ -145,12 +182,13 @@ my $foff = $start - $s->{vma} + $s->{foff};
 printf "Certificate list at file offset 0x%x\n", $foff;
 
 die $vmlinux if (!defined(sysseek(FD, $foff, SEEK_SET)));
-my $buf = "";
-my $len = sysread(FD, $buf, $size);
+$len = sysread(FD, $buf, $size);
 die "$vmlinux" if (!defined($len));
 die "Short read on $vmlinux\n" if ($len != $size);
 close(FD) || die $vmlinux;
 
+}  ### end of ($nr_symbols == 0 && $sysmap eq "") else block
+
 open FD, ">$keyring" || die $keyring;
 binmode(FD);
 $len = syswrite(FD, $buf, $size);
-- 
2.19.1

