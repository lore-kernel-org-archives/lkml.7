Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EFBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62DE23F50
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="bQCds7/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfFDMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:32:06 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:37412 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfFDMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:32:05 -0400
Received: by mail-it1-f172.google.com with SMTP id s16so32006591ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ovmd66lgWZvQORGh1WsP5wWQPg/Z2pj6TQPWmqDhDYs=;
        b=bQCds7/XyIkhexUA0r8bUn1l0f9K1nldG1N/AP8RQIoXPt0IvaxEw1VqGjNvbfxkC9
         rquYd4XEy55VT4RskM9o0AByweInUDw99htQt5XlCy/m1DLUtu4PlfLW5akAFvUFiuq6
         3lUP3hU5QWsFt6bd2NsGYNu4P3bZHgJNEQ+eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ovmd66lgWZvQORGh1WsP5wWQPg/Z2pj6TQPWmqDhDYs=;
        b=N3u2lqGDqZehfwG7WAnbItFU9dPr6mbxciQa2ABrrUNPgoif5Bm95MsNSiVIuXP9Ut
         qLlycoL78xNewwPGbb1jzLrSYB1bf22jNpKZKZfiA0gZXv08H3bEjjvUNLEuJDDWCz81
         VzKqbdtryNawxAZ3FPD3J5HRVhOl+rD9WzhvuscxZkRxJ2tI/yK1xqE6TCfdc+GnRU0n
         s5bdUC1rNiZ95VWyeHsWSk3BCZp8UUTNPacKw3ojDRE4tbFyd/QOQQpFNkYFfzUc3Qd6
         I4sc7pXAZRQBvl/shbZ1EDMF3OjxNZoCahQySZl+QIJ0k/bA0xaFT9+IZcJbqt/cAJny
         fyWA==
X-Gm-Message-State: APjAAAXi20utrvdY46qlxXeZPnPhAsOjfUpzPdw+KduSruhZ4TPmA84q
        71LtKtqQX8BY1tMW3pu6BZ0hYGCzndE=
X-Google-Smtp-Source: APXvYqyUDybO0LnFkI8TFXnpStf5ay7cciKSsMQzM0YdVRuYU308q92RGIotWja0NRG6uUdpechC7A==
X-Received: by 2002:a24:64c5:: with SMTP id t188mr20671874itc.83.1559651524019;
        Tue, 04 Jun 2019 05:32:04 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id c91sm871827itd.4.2019.06.04.05.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 05:32:03 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] udf: Incorrect final NOT_ALLOCATED (hole) extent length
Date:   Tue,  4 Jun 2019 07:31:57 -0500
Message-Id: <20190604123158.12741-1-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following script reveals some errors in the final
NOT_RECORDED_NOT_ALLOCATED extent of a file following use of truncate(1)
to extend the file by adding or manipulating a hole at the end.

The script produces the following output:

 Now testing NOT ALLOCATED extent.
 Testing    0 -->  300 : FAILED - bad extent type/length: expected 8000012C, actual 80000200
 Testing  300 -->  301 : PASSED
 Testing  301 -->  302 : FAILED - bad extent type/length: expected 8000012E, actual 8000012D
 Testing  302 -->  511 : FAILED - bad extent type/length: expected 800001FF, actual 8000012D
 Testing  511 -->  512 : FAILED - bad extent type/length: expected 80000200, actual 8000012D
 Testing  512 -->  513 : FAILED - bad extent type/length: expected 80000201, actual 80000400
 Testing  513 -->  514 : PASSED
 Testing  514 --> 1023 : FAILED - bad extent type/length: expected 800003FF, actual 80000202
 Testing 1023 --> 1024 : FAILED - bad extent type/length: expected 80000400, actual 80000202
 Testing 1024 --> 1026 : FAILED - bad extent type/length: expected 80000402, actual 80000600
 Testing 1026 --> 1538 : FAILED - bad extent type/length: expected 80000602, actual 80000800
 Testing 1538 --> 4096 : PASSED
 Testing 4096 -->    0 : PASSED
 Testing    0 --> 4096 : PASSED
 Testing 4096 -->    0 : PASSED
 Testing    0 --> 4097 : FAILED - bad extent type/length: expected 80001001, actual 80001200
 Testing 4097 -->    0 : PASSED

 Now testing RECORDED extent.
 Testing  512 -->  512 : PASSED
 Testing  512 -->  511 : PASSED
 Testing  511 -->  300 : PASSED
 Testing  300 -->  512 : FAILED - bad extent type/length: expected 00000200, actual 0000012C

 Now testing NOT ALLOCATED beyond RECORDED.
 Testing  512 -->  513 : FAILED - bad extent type/length: expected 00000200 80000001, actual 00000200 80000200
 Testing  513 -->  512 : PASSED
 Testing  512 -->  300 : PASSED
 Testing  300 -->  513 : FAILED - bad extent type/length: expected 00000200 80000001, actual 00000200 80000200
 Testing  513 -->  300 : PASSED
 Testing  300 --> 1538 : FAILED - bad extent type/length: expected 00000200 80000402, actual 00000200 80000600
 Testing 1538 -->    0 : PASSED

 Now testing multiple NOT ALLOCATED.
 Testing    0 --> 1073741312 : PASSED
 Testing 1073741312 -->    0 : PASSED
 Testing    0 --> 1073741313 : FAILED - bad extent type/length: expected BFFFFE00 80000001, actual BFFFFE00 80000200
 Testing 1073741313 -->    0 : PASSED
 Testing    0 --> 1073741824 : PASSED

#!/bin/bash

FS_SIZE=256K
FS_FILE=/tmp/test.udf
MNT=/mnt
ICB_LSN=261
XXD=/usr/bin/xxd

truncate_test()
{
    local prev_size=`ls -l ${MNT}/truncate.test | cut -d' ' -f5`
    printf "Testing %4u --> %4u : " $prev_size $1 
    truncate --size=$1 ${MNT}/truncate.test
    sync
    local new_size=`ls -l ${MNT}/truncate.test | cut -d' ' -f5`

    if [ $new_size -ne $1 ] ; then
        echo FAILED - bad information length
    else
        local ext_type_and_len=`dd if=${FS_FILE} skip=${ICB_LSN} count=1 2> /dev/null | dd bs=1 skip=216 count=4 2> /dev/null | ${XXD} -g4 -e -u | cut -c11-18`
        if [ "$ext_type_and_len" = "$2" ] ; then
            if [ -z "$3" ] ; then
                echo PASSED
            else
                ext_type_and_len=`dd if=${FS_FILE} skip=${ICB_LSN} count=1 2> /dev/null | dd bs=1 skip=232 count=4 2> /dev/null | ${XXD} -g4 -e -u | cut -c11-18`
                if [ "$ext_type_and_len" = "$3" ] ; then
                    echo PASSED
                else
                    echo FAILED - bad extent type/length: expected $2 $3, actual $2 $ext_type_and_len
                fi
            fi
        else
            echo FAILED - bad extent type/length: expected $2, actual $ext_type_and_len
        fi
    fi
}


### MAIN

rm -f $FS_FILE

truncate --size=${FS_SIZE} $FS_FILE
mkudffs --label=TRUNCATE --media-type=hd --uid=1000 --gid=1000 $FS_FILE > /dev/null
echo -n Mounting test filesystem...
sudo mount $FS_FILE $MNT -o loop
echo
touch ${MNT}/truncate.test

echo
echo Now testing NOT ALLOCATED extent.
truncate_test 300  8000012C
truncate_test 301  8000012D
truncate_test 302  8000012E
truncate_test 511  800001FF
truncate_test 512  80000200
truncate_test 513  80000201
truncate_test 514  80000202
truncate_test 1023 800003FF
truncate_test 1024 80000400
truncate_test 1026 80000402
truncate_test 1538 80000602
truncate_test 4096 80001000
truncate_test 0    00000000
truncate_test 4096 80001000
truncate_test 0    00000000
truncate_test 4097 80001001
truncate_test 0    00000000

dd if=/dev/zero of=${MNT}/truncate.test bs=512 count=1 2> /dev/null
echo
echo Now testing RECORDED extent.
truncate_test 512  00000200
truncate_test 511  000001FF
truncate_test 300  0000012C
truncate_test 512  00000200
echo
echo Now testing NOT ALLOCATED beyond RECORDED.
truncate_test 513  00000200 80000001
truncate_test 512  00000200 00000000
truncate_test 300  0000012C
truncate_test 513  00000200 80000001
truncate_test 300  0000012C 00000000
truncate_test 1538 00000200 80000402
truncate_test 0    00000000

echo
echo Now testing multiple NOT ALLOCATED.
truncate_test 1073741312 BFFFFE00
truncate_test 0    00000000
truncate_test 1073741313 BFFFFE00 80000001
truncate_test 0    00000000
truncate_test 1073741824 BFFFFE00 80000200

sudo umount $FS_FILE

------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
 www.digidescorp.com              Earthling, return my space modulator!"

 #include <standard.disclaimer>
