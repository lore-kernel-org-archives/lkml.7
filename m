Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD034C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD1F212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370525;
	bh=AkT0n44v+S5CAKaSgs/CCFCguX4Ebrotd0gjY3kOFjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MOMt66WSNNgl6dOvQCU2NO1IGM2ZFJn3BWn4iso9p2IBZYanHmJGTpIIeaTF72Y8M
	 m/pS7a/T9ZS/KdYiBY03e2zoHz1IVjY5mBce6cADDMOyFHGNbNR0spzGkfXys1VP4Z
	 K5C0aySblwcSmbEcSxs55mxWo5n2HCFct4MZTe9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfFXJ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbfFXJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:57:50 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A6C21530;
        Mon, 24 Jun 2019 09:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370269;
        bh=AkT0n44v+S5CAKaSgs/CCFCguX4Ebrotd0gjY3kOFjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tM/r5zpWpVEmowhN1JCkLRCqpxEyVUmTRexZge5vrba2nhp9zzQpSWyUcMfdz8yn9
         13A/Whk4PZpUsDgNN11wMLgozsZZojYFF8gOZTi1NkGP0ufBITons2ZDdq7CccxFlv
         Mr6JEPznjPCjEAx4MdYtUmCQs6181PEO0AkCQ+sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.14 11/51] apparmor: enforce nullbyte at end of tag string
Date:   Mon, 24 Jun 2019 17:56:29 +0800
Message-Id: <20190624092307.714151995@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 8404d7a674c49278607d19726e0acc0cae299357 upstream.

A packed AppArmor policy contains null-terminated tag strings that are read
by unpack_nameX(). However, unpack_nameX() uses string functions on them
without ensuring that they are actually null-terminated, potentially
leading to out-of-bounds accesses.

Make sure that the tag string is null-terminated before passing it to
strcmp().

Cc: stable@vger.kernel.org
Fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/policy_unpack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -259,7 +259,7 @@ static bool unpack_nameX(struct aa_ext *
 		char *tag = NULL;
 		size_t size = unpack_u16_chunk(e, &tag);
 		/* if a name is specified it must match. otherwise skip tag */
-		if (name && (!size || strcmp(name, tag)))
+		if (name && (!size || tag[size-1] != '\0' || strcmp(name, tag)))
 			goto fail;
 	} else if (name) {
 		/* if a name is specified and there is no name tag fail */


