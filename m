Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B6C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0F22067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfIQTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:43:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43998 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:43:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 370E928A568
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, kernel@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/2] kernel-doc: fix bug and improve dump_struct
Date:   Tue, 17 Sep 2019 16:41:44 -0300
Message-Id: <20190917194146.35642-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series improves kernel-doc script at dump_struct()
subroutine by solving a bug and by making the parser more complete.

The current way that scripts/kernel-doc dump structs do not work for
nested structs with attributes (e.g. __packed) and without type alias
(e.g } alias1;). This is due to the way nested structs members are parsed.

Inside dump_struct(), the regex removes attributes and it surrounds
whitespaces. After that, it will do a foreach(id) loop for each alias.
However, we will have an empty string, and then the split function will
return nothing and the foreach will not have any iteration. The code will
then jump the loop and the substitution will fail since $newmember
is uninitialized.

This bug does not happen when the nested struct has no alias and no
attribute, since at process_proto_type() a whitespace is inserted in
order to ensure that the split will not fail. However, with any
attribute, this whitespace will be removed.

This patch solves this by replacing attributes with one whitespace, to
ensure that will have at least one whitespace. 

Besides solving this bug at patch 1, I also add support for the
____cacheline_aligned_in_smp atribute at patch 2.

For testing and reproducing, create a file `code.h`:

/**
 * struct foobar - description
 * @number0: desc0
 * @number1: desc1
 * @number2: desc2
 */
struct foo {
	int number0;

	struct  {
		int number1;
	} __packed;
	
	struct {
		int number2;
	};

 };

I've tested with CRYPTO_MINALIGN_ATTR, __attribute__((__aligned__(8)))
and __aligned() as well. Now, run the `./script/kernel-doc code.h`,
and this is the output:

Use of uninitialized value $newmember in substitution (s///) at
./scripts/kernel-doc line 1152, <IN> line 18.


.. c:type:: struct foo

   description

**Definition**

::

  struct foo {
    int number0;
    struct {
      int number1;
    };
    struct {
      int number2;
    };
  };

**Members**

``number0``
  desc0

``{unnamed_struct}``
  anonymous

``number2``
  desc2

The output will not display the member number1 and will also display an
uninitialized warning. Running after the patch will get rid of the
warning and also display the description for number1:

[...]

**Members**

``number0``
  desc0

``{unnamed_struct}``
  anonymous

``number1``
  desc1

``{unnamed_struct}``
  anonymous

``number2``
  desc2


To test patch [2/2], just replace __packed for
____cacheline_aligned_in_smp and compare how, at the previous stage the
script believes ____cacheline... is an alias for the struct and after
the patch it is removed just as the others attributes.

Finally, I have compared the output of "make htmldocs" with and without
this patch. No new warning were found and one warning regarding
____cacheline_aligned_in_smp at include/linux/netdevice.h was removed.

Thanks,
	André



André Almeida (2):
  kernel-doc: fix processing nested structs with attributes
  kernel-doc: add support for ____cacheline_aligned_in_smp attribute

 scripts/kernel-doc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.23.0

