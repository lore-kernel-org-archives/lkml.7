Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E57CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D07D21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEXFnTP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfJVUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:09:25 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38030 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbfJVUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:09:25 -0400
Received: by mail-wr1-f43.google.com with SMTP id v9so8209432wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UNVZthZu6v3pyXi3jOLBoCHiTliiyCL5CwMvuY+QdZE=;
        b=gEXFnTP6XUv2nTHtG/e7Y+cBbJB7OGBg8CacRfchlei8vWM9WmtMeaGUqUqHp3V8W3
         PkMq0tjl2m4mvxnB2/0/20VglzOf0ArWZHvFt74HoVgq85Z0IGTESTOPjOUdcRreyvVo
         ozdmXq93RhRzfIDS7moCYZVRNO4JI3ljbzpgi9a8M5YxwlTvP/EB6cK0R/xVGFRASmCo
         Vgkzoc5NejtFBkQGo8Q9GnzDKsWeS32j9ORhXzGrWMLjHgXdTAGJXFrQ/Nia+o1l6wF/
         hOFd6mm+LvYXcsjzKTGikO7NzilqDBH1+DYwRU5DrrolouIED8HQh37CQhajqEKSL8vj
         +Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UNVZthZu6v3pyXi3jOLBoCHiTliiyCL5CwMvuY+QdZE=;
        b=oEdkRXS6MqfbrqYOJHxxgC4NJJ+sgX1RI/bq+PpfEpQLceBbjiB9O/jYWDHBDOWLYH
         o7NIuP4DZyP8PxQl6oA59+ckH+VQD1UasC2natfj3kHP50K1moa/oyX6uz0D14LSsCG0
         L3j0FdMAN3JH6BnZzGwjZ9gc+g8MahFtH4Sn6HoC43icOzUShLOjXAcwF6tyMrpq3OS8
         z8AtgTv/HNHtKy25lE1eu0VS9CGRi759qtaBaY4rRcb1WGFUOkR6cRbaBAPYkv847pAf
         E89bgteCR8q3V9ifyvJcAlZ/lrNeennve+da0SqQt30B0n+DDoyWWuAB2X+ng1Ug+9NL
         A0qg==
X-Gm-Message-State: APjAAAUDMpzwj/7Ru4yjN/24hx8Ti7/AJ9/p/kRoKh44jISyL844NZRR
        10xrKkrqQTqHWbQgu1TnfQ44+ifZVImzFE66FgsXzcGbPG0=
X-Google-Smtp-Source: APXvYqwk23L+slAYpZI8F01d1l2rShuyQ+2yKE9OY22oCI0DTojecFhBlDFWvqVqOosDOekG42q5S68KN5YKGHIkNWA=
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr4981661wrn.29.1571774962099;
 Tue, 22 Oct 2019 13:09:22 -0700 (PDT)
MIME-Version: 1.0
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 22 Oct 2019 13:09:10 -0700
Message-ID: <CAA25o9TABY=3C+FQEg8FDyF1rim315G2hmeB1DBWJLn-wG1j0g@mail.gmail.com>
Subject: is hibernation usable?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>, Bas Nowaira <bassem@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a thread in linux-pm
(https://marc.info/?l=linux-mm&m=157012300901871) I have some issues
that may be of general interest.

1. To the best of my knowledge, Linux hibernation is guaranteed to
fail if more than 1/2 of total RAM is in use (for instance, by
anonymous pages).  My knowledge is based on evidence, experiments,
code inspection, the thread above, and a comment in
Documentation/swsusp.txt, copied here:

 "Instead, we load the image into unused memory and then atomically
copy it back to it original location. This implies, of course, a
maximum image size of half the amount of memory."

2. There's no simple/general workaround.  Rafael suggested on the
thread "Whatever doesn't fit into 50% of RAM needs to be swapped out
before hibernation".  This is a good suggestion: I am actually close
to achieving this using memcgroups, but it's a fair amount of work,
and a fairly special case.  Not everybody uses memcgroups, and I don't
know of other reliable ways of forcing swap from user level.

3. A feature that works only when 1/2 of total RAM can be allocated
is, in my opinion, not usable, except possibly under special
circumstances, such as mine. Most of the available articles and
documentation do not mention this important fact (but for the excerpt
I mentioned, which is not in a prominent position).

Two questions then:

A. Should the documentation be changed to reflect this fact more
clearly?  I feel that the current situation is a disservice to the
user community.

B. Would it be worthwhile to improve the hibernation code to remove
this limitation?  Is this of interest to anybody (other than me)?

Thank you in advance!
