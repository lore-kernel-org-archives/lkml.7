Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F04C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF1820828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dK9oxuvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfGEORn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:17:43 -0400
Received: from mout.web.de ([212.227.17.11]:48141 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfGEORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562336202;
        bh=c5lQmJWmXCyJqkb7xpERrhX/6DJO/0n7l+cLiVF/Z0U=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=dK9oxuvHRAGSTd/930v7lvZ8UJTomW5ZmnfyWweOjiMwcmgjU5IFOnIK2uFg40ibt
         upgic5Ymi6PGGxmClD4bN5odUFHlLL85f/nQqXmvaCXILEBQIwyw2fbtt6RN/5V8xJ
         6cNGhprK4XBvjz3Q9DHZkif9D9L4sgCZ9fs1Vmyo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.45.164]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqoJ-1hrPNC3oYt-009ev7; Fri, 05
 Jul 2019 16:16:42 +0200
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mm/ksm: One function call less in __ksm_enter()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <997c8ec3-9af8-3db0-24dc-cd99fe3efe14@web.de>
Date:   Fri, 5 Jul 2019 16:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vv4GTwoOQWvbscKPArHDFagPebc7zNEGdef0te2GLsIWJh3VMoj
 U0MdqUmq20geVaqHfIwQEjAAImz40y5t5vZ4a0lgid/Cvi+cVllVj7KfPu5KBvCe9ViOGkf
 XUH2LEAF/LhrSsZmmaxp2dRDuBmPYsR7TeLi3CZJdKIYjuj0ANzAarWE7/OlzXiCgl1jgX+
 so9DGRg/Ybh25heqJZVcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7IhvuN2v9c=:xTyg2lv/XDdCSKRup83bsT
 tDJdUbmgpqZ3vZzoewoNRWhE/c6mXikA+jPICJT5Xb4x2MKqOlQ2clalDz9RVFvOHhCyGWgHN
 aOm614YARfeIEMZJmBILxeNwTzLd8Q/Tfasvooe36lXrPbe2rFPdO6M0A2l/HjZKjbvZ2GOBu
 NvGSdCiXLnomkK+65MMic3zcoMgdefMI9GHrmQR56zj0giowtpcHH1WTpxBDNCIBMSUlsvFpV
 KyF2flNna6Oj4gI2oNeijK7gnxoiSZyYfEbhB3hVu5Z4Cv2fOdiHFEhevklj1JXqD8eTc8glN
 ygYB48gH78GLq18FQ0WkgUGu78miScIMZTKWvrvmsFQUonaHrvjmPNzP7JA/VvYjF+XdUVj1X
 //cbVRGqo7MqYnBrhaZzLrTlmYfiocI6CLO6Snb9SgS5TQu14DcfuWlhNRe5XgERdZCK+0jI3
 NdQhcZ0EI0QiBDZ9aAhXATZTZiqstDcs+oAjrCtR1HnXWtb3iTvcCg2K6wjvj7al+O+0/qsKy
 Zo6H8zb+ararCkHKUDkPYmMIdbo0rLjn6TavXFGhLkwypUI2qMkF6g/JncC/s38arHYNDlqOF
 Zawh2wpS7kwc+w3z5Tt0w3HQJ6W7uxdLWuTdsjo/lWutfvetHOLnNeNMbFGgY1lKijZxo0tf+
 D1qJGbf6bAWcUk8bJ5mJFqDjklT9tHgFwMj2VdQEJh2a8u6I8Dh5InqWVzskxPo4GU3UszH0z
 63lBQnO0PoBzGeFLi2L0QRMnazmOGsouXvnQZsLznMR+8cJPjJPBgBJAOQ8cyTwvxtQARUDcg
 zd4XgsgSkuNcVTwGgetPFl5S5wCZrC7AVTpUOkde4U/cMLcWhRB2pV14M2E/tWcpPGmPkJTRY
 kdjzQRSnhwdrT5ZDcXl44+CjWKAIQ6ZxjbWz49Q71arDzVk602N/TaSL0ftfXnC6OPbuQZrtg
 kpErOPpFbWNPetXVF89438pz6i9GEA18or+52tUruqlTLlNjy1cIGQxuxzBysM0VBRP9/dYTU
 RiYOqSGcjTn/lRw9T4hvRsKGh+POJMhMWkwtY3SBnfFSD9lM+C8IQYmOZmiNsIgiCMbRnOY1a
 j2NijmGZAXBL6QFI9/9/tv6zNYRZhpSXtdL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jul 2019 16:02:26 +0200

Avoid an extra function call by using a ternary operator instead of
a conditional statement.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 mm/ksm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3dc4346411e4..7934bab8ceae 100644
=2D-- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2521,10 +2521,10 @@ int __ksm_enter(struct mm_struct *mm)
 	 * scanning cursor, otherwise KSM pages in newly forked mms will be
 	 * missed: then we might as well insert at the end of the list.
 	 */
-	if (ksm_run & KSM_RUN_UNMERGE)
-		list_add_tail(&mm_slot->mm_list, &ksm_mm_head.mm_list);
-	else
-		list_add_tail(&mm_slot->mm_list, &ksm_scan.mm_slot->mm_list);
+	list_add_tail(&mm_slot->mm_list,
+		      ksm_run & KSM_RUN_UNMERGE
+		      ? &ksm_mm_head.mm_list
+		      : &ksm_scan.mm_slot->mm_list);
 	spin_unlock(&ksm_mmlist_lock);

 	set_bit(MMF_VM_MERGEABLE, &mm->flags);
=2D-
2.22.0


