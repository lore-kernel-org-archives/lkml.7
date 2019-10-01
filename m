Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E352070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FFbpvQcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbfJAOb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:31:26 -0400
Received: from mout.web.de ([212.227.17.11]:56479 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfJAObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569940263;
        bh=dtzR+oKkbzZP6BrJC/+YNC1/yA9TF0iE4T8O+gCBJtA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=FFbpvQcJlcjnFtSoYp+gsWoaIWOpRX6Gzam0xwIbsXjjDHXqKL3vh75qFm3uAC3bH
         LxaQYaMuOMxYS0TCvnGSTNb1nYqYXmPvHdZvp26CGYGmbv8djzAyUrnmX/oFYYkVgQ
         ojSfisackmmjxA+qPAXSAgm+0eMVvmva7MZbHg7o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.188.160]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAdx1-1iPSBR3DXH-00BvTx; Tue, 01
 Oct 2019 16:31:02 +0200
Subject: [PATCH v2] Coccinelle: Add a SmPL script for the reconsideration of
 specific combinations of assignment and return statements
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <4977fb04-cc29-3861-0aaf-cd93a0b0b1c7@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c45c4435-581b-d137-255c-c21db7ccef78@web.de>
Date:   Tue, 1 Oct 2019 16:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4977fb04-cc29-3861-0aaf-cd93a0b0b1c7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sXvqV/w8lYbgy3hmdk2HMwLK90Y/rnxI9w6yo/hr7Vo76WhXAs1
 6CxR3yim9pBq42Cg5mpw7KDdjSzwJfs4DKlQC7bFFHqaefFgaiQf74DPaO6t56RmAKKFGu8
 RFCvGWt9I94A8bCVo9hQyHmUXjFFCAzNIYrtxCjwYyrDbbPATtxhaAiZoN6EEwYbKnwqktV
 Zss8vhieVJavkSbGB+A4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6H1CuU5c6wY=:a+rnoUwzhnsVGixprpxtKY
 TP2JTCpWZKtLPiykqp8OP5UHi3qsohtnditkvHg+u5LTFQuR3AOWkU8uT3ngdnroa3FHZSaUm
 yPej2qQetF2f1+g2MqceuP6RsefjWzsPV6MbfTCUSv9YRIlVpsk+kITpmXiwpU3GBXVTp5wPc
 yVfaQt4JFN6RtDnapc5a2RBrqev3o/OVTHEdnfdOzgH4DY9ggnZ00BJGhyZ5yQc5KmMc0g8Qh
 YyhDPGZsYtu0ZBJorOFCZV3fzXqxnYmq22LbP+LU2yms7y1ag+db5l6bjTqsSen8+uKHJyP5Y
 dV+Fj6rSISei+/Y+rQ9eQ4jVmVPdLEyvHpZSvNId1lxGJVppx+MnWsmcOh8yCFbXXxSawPJ0s
 DTCMlVg2l8PWOCV3qc7w14Lu3kOvheLL0enoWdSMR1N+bHQFmXnlhipBndYn7hlapeWcy+Uni
 s8lZlO9qQ1r1s0lw1gY0hHBIvRvPEdXLzMyTl8zfoJt5mKRU6OXYG0j5sA/xTzj+xkh8JNeFr
 rCOamlkmvbyG6kqo3n6shMrbAnYu2nHQeRn3/kEID4sme1Zor61BwA/caFR6yY3EdaNnKz7Uc
 oD3C/Dmk9bod971nhUwpzDBrC/ybZrcxzstlJ+xo+9SrreQh4/0KRmgYNA88548reXN1x0Vgz
 5plpA5BT1Hw0rRMEi+JXfwxhFHe7ZAnAfxSTL6ieZJ0IIeHe6XkEF3v77+YPUmzoIXGkp80LA
 5c8YeJ3XiAMLf9LJmGdP2A5EtJ3IxTX44NJR+h6Ox00x+oQVXwJ7fUlJ6Wi6wNeDV8AORSqzR
 I0ZJlufdpnUeLqoNS09nGpIXvSz9e36BRICTcGIoLLNcPh4bwC6U0iVgs7RMWFkrGf6Q05J2m
 kpWTMNGFT5JE5jWCXMyveqfuHyj7QA7d+fhOyoeyIdZDJzX1HTgTg36eHxHQeWTDQHAfJ6pnQ
 SxCVjaTAqIHCdXDJZhdnvlMaA6qC+vNn9VZ3R96jWFbf/9H+YJZW+vBautTIOpw6P02+zdnfv
 Fz/6eX1V/BTdNray9hxq98rrCz15Pu92wc/lwukU/HdxhosNSEbp/0XnF6+97BTXxdds8tZI5
 BYebSfoHjUjR9U0mtGAzVxUgYbBpT3kGHE7emRzS+LLWVD+4fE0PM5HeFTH50rXeBL1EhCFzx
 3Zra5okSWy6mc/jNzF6k9zdCrnDA5MSYV8b+xyPhzpbH9BE3/fmMINeQmHOsMd676KU/QjZTJ
 Z1lsvNhlG1bKujsVKvgqV43S+MPtAuCx3f+hiRdsrtEBqYzDuO0hWdtLqGWU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 1 Oct 2019 15:50:10 +0200

Values from expressions were occasionally assigned to local variables
before they will be returned by the subsequent statement.
Such expressions can be directly specified in the return statement instead=
.

Adjust affected source code by the means of the semantic patch language
(Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
* Application of the SmPL construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=
=9D
* Addition of a hint for the supported coccicheck operation modes


 .../coccinelle/misc/move_code_to_return.cocci | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 scripts/coccinelle/misc/move_code_to_return.cocci

diff --git a/scripts/coccinelle/misc/move_code_to_return.cocci b/scripts/c=
occinelle/misc/move_code_to_return.cocci
new file mode 100644
index 000000000000..22ce7c9d0fd2
=2D-- /dev/null
+++ b/scripts/coccinelle/misc/move_code_to_return.cocci
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Return expressions directly instead of assigning them to
+/// local variables immediately before affected statements.
+//
+// Keywords: return statements variable assignments coding style
+// Confidence: Medium
+
+virtual patch
+virtual report
+
+@replacement1 depends on patch@
+expression x;
+identifier f, rc;
+local idexpression lrc;
+type rt;
+@@
+ rt f(...)
+ {
+ <+...
+ if (...)
+-{
+-lrc@rc =3D x;
+ return
+-       rc
++       x
+ ;
+-}
+ ...+>
+ }
+
+@replacement2 depends on patch@
+expression x;
+identifier f, rc;
+local idexpression lrc;
+type rt;
+@@
+ rt f(...)
+ {
+ <+...
+-lrc@rc =3D x;
+ return
+-       rc
++       x
+ ;
+ ...+>
+ }
+
+@deletion2 depends on patch@
+identifier replacement2.f, replacement2.rc;
+type replacement2.rt, t;
+@@
+ rt f(...)
+ {
+ ... when any
+-t rc;
+ ... when !=3D rc
+ }
+
+@deletion1 depends on patch@
+identifier replacement1.f, replacement1.rc;
+type replacement1.rt, t;
+@@
+ rt f(...)
+ {
+ ... when any
+-t rc;
+ ... when !=3D rc
+ }
+
+@script:python info depends on report@
+@@
+import sys
+sys.stderr.write("INFO: Unfortunately, specific software limitations have=
 got the consequence that only the operation mode =E2=80=9Cpatch=E2=80=9D =
can be supported by this SmPL script so far as expected.\n")
=2D-
2.23.0

