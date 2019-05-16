Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F6FC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B53620843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557971350;
	bh=JuqOMoW6c7ktOY24yqM8wEy/r/UNtX0V3f/nuZOK5w4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=obsEAwvz3q7rMOQxbAvi6oObu88o6KmaFJ2UFSpw3goQD2z669kp7azyK1NWsds8t
	 SnVuhZGKY517niBL13dhzZ+VcH9N+ZbD4sHpdbJkfjWk+ZgVScpTDpsb3vWvp8qFN0
	 FgrqUdN3q1hLMmGoqmxd/NMqWZq54EbejV3/vbPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfEPBq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37925 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbfEPAID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:08:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C68B24A07;
        Wed, 15 May 2019 20:08:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 15 May 2019 20:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3B23+58MCBnI6sSMS
        /WMrhsI2WSFi56FArifNAuTjdA=; b=MNI6xCxrSTzGInMBjip0r63fwDCqIdaC3
        pZaRuA4F8Nk/cVuEksNb6n6HCfJS36VeZmB0nP7bxeteJFb82Pb65Xw/Co92dzXd
        GHiJwV7j233drpApXjsTRtujbonuRQ7kClhxAfu3lPfj44oEzrHx3XdZ9aD1NyQl
        lXyfEf2Zpad0wa/XUHiGDrACZ1TOaaj1hFuVDP7VWmtkuaj83gMCNvPEIxSk5VVC
        j49WDySRdCtl3G2SEp0GsJ5JEzT2nzd0PW5iASIzwMth3BFzw0HiovbYjVWQPj4V
        YhUasZuAPuPANUp12sAFjg6Seboe5nTsxuLHvPsrgqsh5pmqn3a6g==
X-ME-Sender: <xms:4qncXB5kw69MUyTKZNsZtu-FSDF-_0YOnfq68BiSmXj8rRxhKVIZBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleelgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvvdekrddvfeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:4qncXK9Fy65jc2dbqtq93ZFdNR4KMHqLLlwTntBA7lS5UcbYYISAjg>
    <xmx:4qncXDzb6mUUFXU-pCiKiuUvQ5JvfPNJegR_J9wxye2lK89HR9tY0A>
    <xmx:4qncXJGds42ep1i8iXclYwRfS5K9hLi3QAgPzHKdOgFcqoE-CjtHTQ>
    <xmx:46ncXLx8rNsd1eb_IeEr6DHe8vl3CwGJ1bSGbvG32cHTluBvQrHRYg>
Received: from eros.localdomain (ppp121-44-228-235.bras2.syd2.internode.on.net [121.44.228.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 221CA10323;
        Wed, 15 May 2019 20:08:00 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kobject: Clean up allocated memory on failure
Date:   Thu, 16 May 2019 10:07:16 +1000
Message-Id: <20190516000716.24249-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kobject_add_varg() calls kobject_set_name_vargs() then returns
the return value of kobject_add_internal().  kobject_set_name_vargs()
allocates memory for the name string.  When kobject_add_varg() returns
an error we do not know if memory was allocated or not.  If we check the
return value of kobject_add_internal() instead of returning it directly
we can free the allocated memory if kobject_add_internal() fails.  Doing
this means that we now know that if kobject_add_varg() fails we do not
have to do any clean up, this benefit goes back up the call chain
meaning that we now do not need to do any cleanup if kobject_del()
fails.  Moving further back (in a theoretical kobject user callchain)
this means we now no longer need to call kobject_put() after calling
kobject_init_and_add(), we can just call kfree() on the enclosing
structure.  This makes the kobject API better follow the principle of
least surprise.

Check return value of kobject_add_internal() and free previously
allocated memory on failure.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

Hi Greg,

Pretty excited by this one, if this is correct it means that kobject
initialisation code, in the error path, can now use either kobject_put()
(to trigger the release method) OR kfree().  This means most of the
call sites of kobject_init_and_add() will get fixed for free!

I've been wrong before so I'll state here that this is based on the
assumption that kobject_init() does nothing that causes leaked memory.
This is _not_ what the function docs in kobject.c say but it _is_ what
the code seems to say since kobject_init() does nothing except
initialise kobject data member values?  Or have I got the dog by the
tail?

thanks,
Tobin.

 lib/kobject.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index f2ccdbac8ed9..bb0c0d374b13 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -387,7 +387,15 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
 		return retval;
 	}
 	kobj->parent = parent;
-	return kobject_add_internal(kobj);
+	retval = kobject_add_internal(kobj);
+
+	if (retval) {
+		if (kobj->name)
+			kfree_const(kobj->name);
+
+		return retval;
+	}
+	return 0;
 }
 
 /**
-- 
2.21.0

