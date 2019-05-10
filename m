Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19218C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC34D2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557447519;
	bh=u8xN6Nmxg0NNPKVrB67zCNmGBukEl7Rz4XVw+Q9chiI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tlCM7LxDCps9q8poLhC6S92hn0mhZkd9R4HaqMY+XHFvHjcKN62urTIRHY80BlDk9
	 LGPLpawNUUjHuyiXdhg9YAjilvT+XR3eYgXFXvArAKLGwM+rMjzbcEm3uVqIveeiQK
	 eNdi/VCXABAXXjF+aK2Te1gyxhEmeSKi5bXWrDNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEJASi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:18:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52513 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfEJASi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:18:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE6C422565;
        Thu,  9 May 2019 20:18:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 09 May 2019 20:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mw4O6ev32EJop5PfB
        /p86w6RcybVvIqZIlEya4JoZns=; b=J0QYo2X9xQcfQjHUMVOu0dP7N5wvkinK/
        clSCYYIish7/4Hzs9KTcoofNoY27e+G1NfYBZ5m2k12/n+wzJP6Lx82T4ez3Kzw8
        VFJEEDImiYRKqsf1UgJoQupDFRTCn6rBbyvPpXOGFby5FHf+QaxZqaOsw9vupfQ4
        vCNdyEcuzYFAVf4BwqPvak/LvIPAPiiGBVr+Edz2z4rGnMzTFykr+8lnGNr0pj0I
        ECAITX/ypB8YJ1KFMkFI93YjQHH7wCsjui+NQquepUHeYLReuQJj73VhxDGuBRdP
        CZ+/tetfvErWDA2rKEvGEDD15Kjk3cejCBXaowY8ofbiY4e7EBlrQ==
X-ME-Sender: <xms:WsPUXNZBgkjWY9WCjLjlrgxV5m_X_UyLLevt8EFpIEcHzm3axrrS8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeeigddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    duvdegrddujedurddvuddrhedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:WsPUXHDVvf-WST9AhMBMi_YMiI_zDHC3C1t6JielzA_wlRvfnpdRnw>
    <xmx:WsPUXENSEtfsTPJaJ2vWs7rJ62N3geSxKfnCRXxT9r11mrZ2i7bxZw>
    <xmx:WsPUXHCNJ9oqvND3lTUd8NJew6-Etzlk2dXI_KaCBkvpugLI0ToqBA>
    <xmx:WsPUXM3JybyTV0aMIVegkic13oNS5otKHG362XkC5ZShedtHRfH_5w>
Received: from eros.localdomain (124-171-21-52.dyn.iinet.net.au [124.171.21.52])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BAC580063;
        Thu,  9 May 2019 20:18:31 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Move kref.txt to core-api/kref.rst
Date:   Fri, 10 May 2019 10:17:47 +1000
Message-Id: <20190510001747.8767-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kref.txt is already written using correct ReStructuredText format.  This
can be verified as follows

	make cleandocs
	make htmldocs 2> pre.stderr
	mv Documentation/kref.txt Documentation/core-api/kref.rst
	// Add 'kref' to core-api/index.rst
	make cleandocs
	make htmldocs 2> post.stderr
	diff pre.stderr post.stderr

While doing the file move, fix the column width to be 72 characters wide
as it is throughout the document.  This is whitespace only.  kref.txt is
so cleanly written its a shame to have these few extra wide paragraphs.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

I'm always hesitant to do docs patches that seem obvious - is there
some reason that this was not done previously?

I did this one in preparation for converting kobject.txt, my intent is
to put kboject.rst in core-api/ also?

I can split the whitespace change and the file rename into separate
patches if you'd prefer.

thanks,
Tobin.

 Documentation/core-api/index.rst              |  1 +
 Documentation/{kref.txt => core-api/kref.rst} | 24 +++++++++----------
 Documentation/kobject.txt                     |  4 ++++
 3 files changed, 17 insertions(+), 12 deletions(-)
 rename Documentation/{kref.txt => core-api/kref.rst} (93%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index ee1bb8983a88..1c95f0cdd239 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -34,6 +34,7 @@ Core utilities
    timekeeping
    boot-time-mm
    memory-hotplug
+   kref
 
 
 Interfaces for kernel debugging
diff --git a/Documentation/kref.txt b/Documentation/core-api/kref.rst
similarity index 93%
rename from Documentation/kref.txt
rename to Documentation/core-api/kref.rst
index 3af384156d7e..a2174dd09eb2 100644
--- a/Documentation/kref.txt
+++ b/Documentation/core-api/kref.rst
@@ -230,8 +230,8 @@ of the free operations that could take a long time or might claim the
 same lock.  Note that doing everything in the release routine is still
 preferred as it is a little neater.
 
-The above example could also be optimized using kref_get_unless_zero() in
-the following way::
+The above example could also be optimized using kref_get_unless_zero()
+in the following way::
 
 	static struct my_data *get_entry()
 	{
@@ -261,11 +261,11 @@ the following way::
 		kref_put(&entry->refcount, release_entry);
 	}
 
-Which is useful to remove the mutex lock around kref_put() in put_entry(), but
-it's important that kref_get_unless_zero is enclosed in the same critical
-section that finds the entry in the lookup table,
-otherwise kref_get_unless_zero may reference already freed memory.
-Note that it is illegal to use kref_get_unless_zero without checking its
+Which is useful to remove the mutex lock around kref_put() in
+put_entry(), but it's important that kref_get_unless_zero is enclosed in
+the same critical section that finds the entry in the lookup table,
+otherwise kref_get_unless_zero may reference already freed memory.  Note
+that it is illegal to use kref_get_unless_zero without checking its
 return value. If you are sure (by already having a valid pointer) that
 kref_get_unless_zero() will return true, then use kref_get() instead.
 
@@ -312,8 +312,8 @@ locking for lookups in the above example::
 		kref_put(&entry->refcount, release_entry_rcu);
 	}
 
-But note that the struct kref member needs to remain in valid memory for a
-rcu grace period after release_entry_rcu was called. That can be accomplished
-by using kfree_rcu(entry, rhead) as done above, or by calling synchronize_rcu()
-before using kfree, but note that synchronize_rcu() may sleep for a
-substantial amount of time.
+But note that the struct kref member needs to remain in valid memory for
+a rcu grace period after release_entry_rcu was called. That can be
+accomplished by using kfree_rcu(entry, rhead) as done above, or by
+calling synchronize_rcu() before using kfree, but note that
+synchronize_rcu() may sleep for a substantial amount of time.
diff --git a/Documentation/kobject.txt b/Documentation/kobject.txt
index ff4c25098119..140030b4603b 100644
--- a/Documentation/kobject.txt
+++ b/Documentation/kobject.txt
@@ -159,6 +159,10 @@ kernel at the same time, called surprisingly enough kobject_init_and_add()::
     int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
                              struct kobject *parent, const char *fmt, ...);
 
+An error return from kobject_init_and_add() must be followed by a call to
+kobject_put() since the 'init' part of this function is always called and the
+error return is due to the 'add' part.
+
 The arguments are the same as the individual kobject_init() and
 kobject_add() functions described above.
 
-- 
2.21.0

