Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB2DC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F089121019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfGLKwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:52:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGLKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:52:17 -0400
Received: from [192.168.1.110] ([77.9.38.202]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIMOy-1hiZFD2G04-00EP0N; Fri, 12 Jul 2019 12:52:15 +0200
To:     LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: NULL pointer constraints vs. compiler checks
Organization: metux IT consult
Message-ID: <732996cf-5813-22a3-ee69-d8dc353845f4@metux.net>
Date:   Fri, 12 Jul 2019 12:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eDjw4wbraMlZJSs59JKpHBRDvOW73+W+qNBXn/MmPDlHhA1v+j9
 tjILmbKLmWRiQdCzg80YeQlx+jxAFL1hkHjWMifC8LHnYpwMAf12pC2aGg3nzmkkZXo9nbz
 zCsioxAngGrJJEGag1O6k1rDmb8I4c/qLgpYNI+sKOEoUrJ5OdlAMg8kju/KZ0m1oMvOUMG
 hc8L3HHQudYfhwfn4DO2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aqrP9gfRmsA=:Nd3eMdLucqxjCRYoQgNrb2
 xAjWjEOlqklDugngomYkF7ph5GynXF7uMN6Y5kbBu61tYRmsvXTbKkjFiQiINTyBmgmTAnfZJ
 w/U6bsOpe69INm0VLsmM5e/PumXTiXw23mDXcZYjUJLBvkm6+YsLRFFjvmGEYrmr5+j8wWZ8b
 C+C7ewBnNk4DloMdGtcwZbqI0+RzcIIo3FguHeQFUXkTn0jtbhXzE6wsxFcaY1qtMthvybaCM
 sQWN1J94MMG3Dpyb6uLYWQ9N8RE486VBJLlcD/AbittVT2PJIMtehQDgef+D3wutImtjvc9bz
 GpxQvaKnrFi1la9EqhC1m/Rzj2HRHAJhVBFOaAxJgbxREEml5q6SH6io58cGOUZ8Ixdk847gk
 xjuT8bXMIJ11T1pQ8AFiPxa9L5W9dyqJirDrA6tz3eAKB8HhWlY5xWwr6wbp//nzZKF25fMUW
 E6u9LCXxqsBp0Ccsc5vNDChzylgUEEiOdycJ/UbndAwQ7eDql5cYZEjfecyQ0FIiZGF9TnIST
 +HuwEdjYNSW8Hc/G6UQDv/MfSIx1+Q5qBNK2f3VoS1WIrVXdd+dazB2xwzEIE9TDIBa7Gfv5D
 6inpRgYWDzwXhzQm5zJXiRRDUaE5QwjNxSCd0KPAmVW6u+aWUOMNLm5ByfjtEw6j7fC98omUj
 1IbcF/O7i0Gu+B8sJeUTNMdKXOjjLbMpicldfI+xUAImkrYKCCyYVhW8ofTs04+jkfOD2p11e
 CvS4YAj+De0cYFAm5NtJ1RE9MQm9KHYPnDI0QmdF/24VeyIoVBxeHFckz+Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


we recently have lots of patches for either adding missing NULL checks,
removing unneeded ones, etc. It seems that's an non-trivial terrain,
so I'm thinking about potential compiler support.

Does anybody know whether gcc has some way for not-null constraints ?


thx
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
