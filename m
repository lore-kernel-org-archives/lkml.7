Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682E8C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3006320815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYHU70lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfJBXqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:46:11 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:43842 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJBXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:46:11 -0400
Received: by mail-io1-f41.google.com with SMTP id v2so1311539iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KUL6bHuyd6MPyiHffWs6sdWsw3czUJgB2Xe08L7XvUI=;
        b=CYHU70lDFBhJVrNF3iFei9VkUZuuDX18M/jsXgvvk3M/sSahCCjd4plBeepaGsqUTc
         dgFiYPYVH0jMMs0GqKaeTV5b79YtPEBf0VC0QyUMDiABax1/5B2ggaSJQAfSerOdUw4a
         NcfSQwqEzPybM9/dhLV1iDwjGdisTWcZ22R/CzCmVCpFBdbEdHgebA/tW9hHqmQKwCpm
         W+3BKLhQnuUad9QQ5BXXUMdQmkvkUDreXUh/jBMqfXmQBGeFGt/OOQn7qYg720RKSE0I
         v1G/5qV0JlBNpP0HtKPtDyr01JqZuygE9A5vNwugLLSA7Ut3JCnmT3cRhzHFTQgQg4ev
         hMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KUL6bHuyd6MPyiHffWs6sdWsw3czUJgB2Xe08L7XvUI=;
        b=GHEyhMbDmfTo7IZsRLEZ+e/Qq5tlsPMgk4ACfMa9uh7Q90zLmwAYAlCXWEr8IJtWhU
         p9uKiWhoNvVfERrG7o7tYDI0dbq0vCq/lE3a9qmbXAwYIRaeoFoOUZiJIJoT07HKbBXy
         P/aciZgwriH/pHxqYH0AgKu4YX5ezjcNcr/jdC0/vE3dYQu1FgDKtrXqCxYSY5cgz1CL
         s+H9Qj+J3BYfCtOap3LPNKfDW1VWk2Kfgg9LW236ahMHumxftdvOo1m5aahYo2J9XdRj
         34YonedCH/WwajMeZYePbI3T/EzTknZy6oMbdwUfKUy9P/9WywapVxakI7IbuEbjypdO
         zQbw==
X-Gm-Message-State: APjAAAX5e9ltAYy7jaxzlEt4muLMHGNUg/o8qmlvqDmhs1EvWYyIHRg2
        Bskh0PUpQnOT/T5H1++DWdyE8grm89WEF5bPB+nGTnfwFkg=
X-Google-Smtp-Source: APXvYqxbTG9C5eeoafRc6tR7cI7tZdW857Z/youqzkOxmFhjqf/RYwPiZYzDbOHkcH+20/KHqOOE8bzyv32cbTpNsTY=
X-Received: by 2002:a92:1657:: with SMTP id r84mr6603283ill.5.1570059970000;
 Wed, 02 Oct 2019 16:46:10 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 2 Oct 2019 18:45:59 -0500
Message-ID: <CAH2r5mv49T9gwwoJxKJfkgdi6xbf+hDALUiAJHghGikgUNParw@mail.gmail.com>
Subject: nsdeps not working on modules in 5.4-rc1
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the instructions in Documentation/namespaces to autogenerate
the namespace changes to avoid the multiple build warnings in 5.4-rc1
for my module ... I am not able to get nsdeps to work.   For example
in my module directory (fs/cifs) trying to build with nsdeps:

      make -C /usr/src/linux-headers-`uname -r` M=`pwd` modules nsdeps

gets the error "cat: ./modules.order: No such file or directory"

This is on Ubuntu 18, running current 5.4-rc1 kernel.  It looks like
it is looking for modules.order in the wrong directory (it is present
in fs/cifs - but it looks like it is looking for it in /usr/src where
of course it won't be found)

I am trying to remove the hundreds of new warnings introduced by
namespaces in 5.4-rc1 when building my module e.g.

WARNING: module cifs uses symbol __fscache_acquire_cookie from
namespace .o: $(deps_/home/sfrench/cifs-2.6/fs/cifs/cache.o), but does
not import it.
-- 
Thanks,

Steve
