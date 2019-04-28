Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D6AC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE8720881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556412645;
	bh=dB8Lv4SPiVzGFh70UkcP+XSiZEq5018FKgvrBspyDGo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Sp8GsUjHpsEwNCX/NL+fVaaUmZAVtDMgniJV9pTdx/HQI7kQvrJeEG362qrrpHm60
	 JsZ/F6+Tlmikqitdm8pQ5lSZEeRkJhZzCxDKyXJySbEXCKLEFwfDlvGbWyMTS6WYpl
	 N3mfbBrSKj4t/319IwTXUb0OGyh+ZZd+1LCg3t7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfD1AtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 20:49:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53991 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfD1AtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 20:49:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7853621F3C;
        Sat, 27 Apr 2019 20:49:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 27 Apr 2019 20:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OmKzEB19QJgkSnuRJ
        D6O8/ufMzleOWJBuqcvgW7AdQw=; b=UWIriafO5BZz8MdWpLcZNFvo01SW59KCZ
        ocZ3UCsQGPW3aU4/jwLsimvLY9whKgtIqjLfn0hS5+9U4mHnCS8zydDCnN8gXB5B
        eblbdr5883Og0m7On70M0XXVkpX5k8Dmwe+AYMlM/oFBFRQyKSFcGxkhm7nseAyo
        7xPUqiHjq00aMidfi83DC7PG/rRYEfFkGmFg++h2Eg6z3eqfRki4CFCjjgwJ/kr9
        TKnw7iFmWOJnciSucSaE3hmtPhScsRuRvnfTEtek5wsSVtL3y33auCExQMHrLVu5
        HXy2xKReYk12yZn7MxbSpf/eqyh8etdd9nzK6szCOBz+kg1Y+VtxA==
X-ME-Sender: <xms:fvjEXI3fQiInldJMP43oFAqgAf63U7imk114HFvzmOCdtUFUQzfMPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheelgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dukedrvdduuddrvddttddrudeileenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:fvjEXJrm8xy1IVFlKp1_q1AMeEgbZNAoliYgiX7C2RAORDO5MJNcCQ>
    <xmx:fvjEXCnp4qtSNNpQzri-7LjgspIqE42yNWSLDlAmrDYq36x-kaxLyw>
    <xmx:fvjEXLRu0z5kmF-nEQSgZVup-8mSMSUH65ol5BVDBHr2XwWM7Myeyw>
    <xmx:fvjEXAI1lstwybuKJYbTFNOiuR9vHr3iTkoLu-LSlijwDWFtxuqwlA>
Received: from eros.localdomain (ppp118-211-200-169.bras1.syd2.internode.on.net [118.211.200.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BC38103D3;
        Sat, 27 Apr 2019 20:49:00 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: Improve docs for kobject_add/del
Date:   Sun, 28 Apr 2019 10:48:10 +1000
Message-Id: <20190428004810.11376-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently some confusion on how to wind back
kobject_init_and_add() during the error paths in code that uses this
function.

Add documentation to kobject_add() and kobject_del() to help clarify the
usage.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

The assumption is that this is the correct usage, and that's what I've
tried to document.  Is this correct?

void fn(void)
{
	int ret;

	ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
	if (ret) {
		kobject_put(kobj);
		return -1;
	}

	ret = some_init_fn();
	if (ret)
		goto err;

	ret = some_other_init_fn();
	if (ret)
		goto other_err;

	kobject_uevent(kobj, KOBJ_ADD);
	return 0;

other_err:
	other_clean_up_fn();
err:
	kobject_del(kobj);
	return ret;
}

thanks,
Tobin.

 lib/kobject.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index aa89edcd2b63..b2670671977b 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -397,15 +397,19 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
  * is assigned to the kobject, then the kobject will be located in the
  * root of the sysfs tree.
  *
- * If this function returns an error, kobject_put() must be called to
- * properly clean up the memory associated with the object.
- * Under no instance should the kobject that is passed to this function
- * be directly freed with a call to kfree(), that can leak memory.
- *
  * Note, no "add" uevent will be created with this call, the caller should set
  * up all of the necessary sysfs files for the object and then call
  * kobject_uevent() with the UEVENT_ADD parameter to ensure that
  * userspace is properly notified of this kobject's creation.
+ *
+ * Return: If this function returns an error, kobject_put() must be
+ *         called to properly clean up the memory associated with the
+ *         object.  Under no instance should the kobject that is passed
+ *         to this function be directly freed with a call to kfree(),
+ *         that can leak memory.
+ *
+ *         If this call returns successfully and you later need to unwind
+ *         kobject_add() for the error path you should call kobject_del().
  */
 int kobject_add(struct kobject *kobj, struct kobject *parent,
 		const char *fmt, ...)
@@ -580,6 +584,9 @@ EXPORT_SYMBOL_GPL(kobject_move);
 /**
  * kobject_del - unlink kobject from hierarchy.
  * @kobj: object.
+ *
+ * This is the function that should be called to delete an object
+ * successfully added via kobject_add().
  */
 void kobject_del(struct kobject *kobj)
 {
-- 
2.21.0

