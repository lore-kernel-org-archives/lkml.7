Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D24C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82C821929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931810;
	bh=EGeevMO/gUf+Nnn2/iDfa/HkxbyhqMByHJ3zeC0NUl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nrl/pkLDBoR3LPNni7MLx2F1S37wKPz9bn83DiVxrDJSUh2AXH4iNSt9ercjqWqPm
	 3NVLp0XjIdU65VwFEmSi2uMazwz+baOHIw/mAtdjc++Yil/KXWm5VgEOrE9vRdhSSf
	 NST07aLLyOMmQ2z34HFL0KHeMzRF4bxpPZHCVgKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406983AbfISWXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406972AbfISWX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:23:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A85C2196E;
        Thu, 19 Sep 2019 22:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931807;
        bh=EGeevMO/gUf+Nnn2/iDfa/HkxbyhqMByHJ3zeC0NUl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0/oQV75DPDTQJT90JUl7M25Xva0/yIG8kjCbxsJBdn/9TFSKtLPE0vH6EAssZxJZ
         5wvGg1he1csDYf6e0Z0ntFADvLH6wdoKqtiDW/xp80s6z34f/nSNIvnhnpboaDtUct
         7PgwR0JmibCyQW6egp9jhbtXtUgsrRkXmGf7NB2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 47/56] cifs: set domainName when a domain-key is used in multiuser
Date:   Fri, 20 Sep 2019 00:04:28 +0200
Message-Id: <20190919214801.645282245@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit f2aee329a68f5a907bcff11a109dfe17c0b41aeb ]

RHBZ: 1710429

When we use a domain-key to authenticate using multiuser we must also set
the domainnmame for the new volume as it will be used and passed to the server
in the NTLMSSP Domain-name.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 9cb72fd40eff3..90e0c51ac0450 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2466,6 +2466,7 @@ static int
 cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 {
 	int rc = 0;
+	int is_domain = 0;
 	const char *delim, *payload;
 	char *desc;
 	ssize_t len;
@@ -2513,6 +2514,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 			rc = PTR_ERR(key);
 			goto out_err;
 		}
+		is_domain = 1;
 	}
 
 	down_read(&key->sem);
@@ -2570,6 +2572,26 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 		goto out_key_put;
 	}
 
+	/*
+	 * If we have a domain key then we must set the domainName in the
+	 * for the request.
+	 */
+	if (is_domain && ses->domainName) {
+		vol->domainname = kstrndup(ses->domainName,
+					   strlen(ses->domainName),
+					   GFP_KERNEL);
+		if (!vol->domainname) {
+			cifs_dbg(FYI, "Unable to allocate %zd bytes for "
+				 "domain\n", len);
+			rc = -ENOMEM;
+			kfree(vol->username);
+			vol->username = NULL;
+			kfree(vol->password);
+			vol->password = NULL;
+			goto out_key_put;
+		}
+	}
+
 out_key_put:
 	up_read(&key->sem);
 	key_put(key);
-- 
2.20.1



