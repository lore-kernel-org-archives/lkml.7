Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D4C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18EA214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXVM/MiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfKGN7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:59:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41866 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfKGN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:59:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so1668145lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zUtIMonLuqK+iWfJbM+SRmDj7hvvfURy8hJeahep4/Y=;
        b=JXVM/MiDFcTdxX8cy44MVmFzKHZugo548aLLV3zop3h5hHOXAzYT6dhtTgattam5zn
         ZHy819NPhLltJnzWcFS5twZCvlR/8x3QLB6r3t4Po1F5oZONbOnSc5g9AgbLwvWauhAi
         yotfq3heZSqtcjbCavMNKNiRu404KbTrb8pgpcIdV9hTDi58CHPXULq304hVVwb2hBg0
         6LODreUSFrglTydMSlJB/vAnPGzhHTgpXFAVvGI4lUsl2yd05M9aWPgtQwLxEHa4m1b5
         FBx+2dk1QMCjwaR6V/2DuSKPMW6c83nrwZUb94/uuRwUAIdlFIbwl3gnqLM4MRRIp0Pm
         be8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zUtIMonLuqK+iWfJbM+SRmDj7hvvfURy8hJeahep4/Y=;
        b=iCxlAfefGtkgBvgfZMEuymEyscw6COBPuXBdaJOYR9ZL+Z7dnQpsBj4BhxShTj5Yer
         qSYs9Jr9LdhViZlYlRe7NZBVgfnHMmCRKRvZAUKHQCWWg0f5XI0M6FQzbAT2toiZ2j8T
         WcBUyRYXWxVxwiKklfvHlo+XYtegBZaWzqLLr3/BJ2yVYOcGZMsBPDONzrU4qtIk7bye
         sflKphN5hVaiXNEzeIg0OItaMezq2ZBQQOfSzAC3iJCQbAA4koZGDSsJnFCZXybijLA4
         JSWcbtJpKzP7qr4zobARP5RlzZyCy5rmGK4BU7vWYS7hZVhoZ9dIBfHpad3J2+HPhw7k
         LuQQ==
X-Gm-Message-State: APjAAAVoWNTHUIxA5j07Zb1dKj9IxTriw5k6SQ6tp1XiIStOeRXZA1tV
        WrstCgW0nvmQSYOhh9Zf918ksfihd8cjipwSENcwBw==
X-Google-Smtp-Source: APXvYqxuBAK2h3pUAqLUZxbZFw8/Si0iNv8WQG1sEpgRk4H5vaETXamgdrUD+1wEZUttCeRSrNtVZwS+MutL6tIi1p8=
X-Received: by 2002:ac2:5930:: with SMTP id v16mr2612552lfi.67.1573135174476;
 Thu, 07 Nov 2019 05:59:34 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Nov 2019 19:29:23 +0530
Message-ID: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
Subject: LTP: diotest4.c:476: read to read-only space. returns 0: Success
To:     LTP List <ltp@lists.linux.it>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP test case dio04 test failed on 32bit kernel running linux next
20191107 kernel.
Linux version 5.4.0-rc6-next-20191107.

diotest4    1  TPASS  :  Negative Offset
diotest4    2  TPASS  :  removed
diotest4    3  TPASS  :  Odd count of read and write
diotest4    4  TPASS  :  Read beyond the file size
diotest4    5  TPASS  :  Invalid file descriptor
diotest4    6  TPASS  :  Out of range file descriptor
diotest4    7  TPASS  :  Closed file descriptor
diotest4    8  TPASS  :  removed
diotest4    9  TCONF  :  diotest4.c:345: Direct I/O on /dev/null is
not supported
diotest4   10  TPASS  :  read, write to a mmaped file
diotest4   11  TPASS  :  read, write to an unmapped file
diotest4   12  TPASS  :  read from file not open for reading
diotest4   13  TPASS  :  write to file not open for writing
diotest4   14  TPASS  :  read, write with non-aligned buffer
diotest4   15  TFAIL  :  diotest4.c:476: read to read-only space.
returns 0: Success
diotest4   16  TFAIL  :  diotest4.c:180: read, write buffer in read-only space
diotest4   17  TFAIL  :  diotest4.c:114: read allows  nonexistant
space. returns 0: Success
diotest4   18  TFAIL  :  diotest4.c:129: write allows  nonexistant
space.returns -1: Invalid argument
diotest4   19  TFAIL  :  diotest4.c:180: read, write in non-existant space
diotest4   20  TPASS  :  read, write for file with O_SYNC
diotest4    0  TINFO  :  2/15 test blocks failed

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-dio-tests/dio04

Test case source link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/io/direct_io/diotest4.c

Test case description:

* NAME
* diotest4.c
*
* DESCRIPTION
* The program generates error conditions and verifies the error
* code generated with the expected error value. The program also
* tests some of the boundary condtions. The size of test file created
* is filesize_in_blocks * 4k.
* Test blocks:
* [1] Negative Offset
* [2] Negative count - removed 08/01/2003 - robbiew
* [3] Odd count of read and write
* [4] Read beyond the file size
* [5] Invalid file descriptor
* [6] Out of range file descriptor
* [7] Closed file descriptor
* [8] Directory read, write - removed 10/7/2002 - plars
* [9] Character device (/dev/null) read, write
* [10] read, write to a mmaped file
* [11] read, write to an unmaped file with munmap
* [12] read from file not open for reading
* [13] write to file not open for writing
* [14] read, write with non-aligned buffer
* [15] read, write buffer in read-only space
* [16] read, write in non-existant space
* [17] read, write for file with O_SYNC

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: c68c5373c504078cc0e0edc7d5c88b47ca308144
  git describe: next-20191107
  make_kernelversion: 5.4.0-rc6
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/641/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/641

Best regards
Naresh Kamboju
