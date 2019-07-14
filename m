Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BF8C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D8C2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="hI0eo4pX";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="RFfjU491"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfGNO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 10:28:49 -0400
Received: from mail133-22.atl131.mandrillapp.com ([198.2.133.22]:64923 "EHLO
        mail133-22.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728146AbfGNO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:28:48 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 10:28:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=OkdXMsKChIXf9sKU+iNJjSMcEzWlygaeee1sm+U5lN8=;
 b=hI0eo4pXQR7WcCdkgceq06PJv1FnDQSfHzpSP+X1mDAx3a6YXoynN3MF+p4YL6vmvx+iiI9yJOlE
   a5Gj1rrfUKThLSiv94cxAcSg6uUQWz/wg/NZMqjFCBwCHJ8xzbTBtAFqKYY8PsYobcQTWleXn471
   PdYNYbf/Eq44iF4bPic=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-22.atl131.mandrillapp.com id h5cu201sar80 for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 14:13:46 +0000 (envelope-from <bounce-md_31050260.5d2b389a.v1-e6694e65523f4296bd3ba94a5f0e745c@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1563113626; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=OkdXMsKChIXf9sKU+iNJjSMcEzWlygaeee1sm+U5lN8=; 
 b=RFfjU491ulfpFu5evYLVgEiYJ+CXHsUtgW5fXS4I52GRBPDLo3a+KVwyvSaHNS6nh522vu
 e+NGwA+A2KAxp4jx9w+LN913IPjL8BhX45OK9kB2kSv/CswCRQ8ERJA1jVrZTV649SP9p5wA
 kSCYWFJUS1tupfWAbZEVntDlGLKsM=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PULL] stream_open bits for Linux 5.3
Received: from [87.98.221.171] by mandrillapp.com id e6694e65523f4296bd3ba94a5f0e745c; Sun, 14 Jul 2019 14:13:46 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, Jan Blunck <jblunck@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <cocci@systeme.lip6.fr>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <20190714141317.GA20277@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.e6694e65523f4296bd3ba94a5f0e745c
X-Mandrill-User: md_31050260
Date:   Sun, 14 Jul 2019 14:13:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider pulling the following stream_open related bits:

This time on stream_open front it is only two small changes:

- the first one converts stream_open.cocci to treat all functions that
  start with wait_.* as blocking. Previously it was only wait_event_.*
  functions that were considered as blocking, but this was falsely
  reporting deadlock cases as only warning. The patch was picked by
  linux-kbuild and already entered your tree as 0c4ab18fc33b.
  It is thus omitted from hereby pull-request.

- the second one teaches stream_open.cocci to consider files as being
  stream-like even if they use noop_llseek. I posted this patch for
  review 3 weeks ago[1], but got neither feedback nor complaints.

  [1] https://lore.kernel.org/lkml/20190623072838.31234-2-kirr@nexedi.com/


The changes are available for pulling from here:

	https://lab.nexedi.com/kirr/linux.git stream_open-5.3


Thanks beforehand,
Kirill


Kirill Smelkov (1):
      *: convert stream-like files -> stream_open, even if they use noop_llseek

 drivers/hid/hid-sensor-custom.c          | 2 +-
 drivers/input/mousedev.c                 | 2 +-
 scripts/coccinelle/api/stream_open.cocci | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)
