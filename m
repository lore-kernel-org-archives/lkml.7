Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90BCC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmXGcAXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfFTIIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:08:06 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44625 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFTIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:08:05 -0400
Received: by mail-lf1-f48.google.com with SMTP id r15so1710973lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5nLDF4KvNjOO0UGhzTbw+kgDFdu3GO4N4s2vFIPF9iU=;
        b=OmXGcAXDCg5tpnkC3zM065z42PKi+z/FVjoDHqkRFwQQ351XflSo05WQbSV3o17OA1
         ZCsdnjvvy8dS/tX2Yrk0+vtSVbKzdotrcrp1d3vJpozy0Jdb5LybpVHsiW48i/dDVI4m
         ck78rIIOF3bMUbZaiZAMkWKmJcJn6Z/ZVjyWEsqoSws8e7XxsYNIIMXEHmshvOdBKAcx
         J/hpS3vishBxStBuT5Vd6dFmaBnP06wN4IJ6LTtHWz3vxRs0dzNXAKspTbq1O91EelUW
         7USUCZOQGv2Sw7kPzWpfZs5oEBsiyWFpcnyvM6d2Eb0IbXkpG8FtvbT1xWFcC5FeFvd/
         egbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5nLDF4KvNjOO0UGhzTbw+kgDFdu3GO4N4s2vFIPF9iU=;
        b=O0dAu3g1c2zpTiuIz1xZUMFkZ+PIxoW8WEXPHcgmmUV/m9xv/gDjqjLiSHLUywfC+R
         NE/6DzVLjTa4Ely2i8f21dkNTp6UN5dkN/GlbscUQpmYoUi6cvKiSXAVt5edgeHeF89d
         ohPUx7jDZLMXmfn07o2QFDkbPazn93FAmbBFeYALL8/dwLs4yC+moCy7+9RPO+4cengR
         pcaELFE1mQKUN2IhsF5GvWlrXr8kp2x8ClItu5BGWve2tjC+hfBYttl7c/c186JmL1zE
         NdsRCvoYWy5ivg0wTUJBUEyjbGKiCHGX8wc4X0hHlg6No1ABmS4lbffPGFh6gJRfwUoh
         xlbg==
X-Gm-Message-State: APjAAAXGapMrsiVE6g+lthN7iR1Gu/nBtpMfKKj8rb6nWzygC/TPNTfH
        /ZdqjkRcGSeXs5OVe6spoe5dXQUER1FIhAX43O0pRA==
X-Google-Smtp-Source: APXvYqyU7SYZ3r1zFZE21AN1DFeMgGQwh6SguX3BRtEUzUX/aM0TrfFkxtA08Wzok29Qq+v25QAmavsjX/AI8Qz4iuA=
X-Received: by 2002:a19:671c:: with SMTP id b28mr12475324lfc.164.1561018083426;
 Thu, 20 Jun 2019 01:08:03 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Jun 2019 13:37:52 +0530
Message-ID: <CA+G9fYsMcdHmKY66CNhsrizO-gErkOQCkTcBSyOHLpOs+8g5=g@mail.gmail.com>
Subject: selftests: bpf: test_libbpf.sh failed at file test_l4lb.o
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        xdp-newbies@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, kafai@fb.com,
        Yonghong Song <yhs@fb.com>, john.fastabend@gmail.com,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests: bpf test_libbpf.sh failed running Linux -next kernel
20190618 and 20190619.

Here is the log from x86_64,
# selftests bpf test_libbpf.sh
bpf: test_libbpf.sh_ #
# [0] libbpf BTF is required, but is missing or corrupted.
libbpf: BTF_is #
# test_libbpf failed at file test_l4lb.o
failed: at_file #
# selftests test_libbpf [FAILED]
test_libbpf: [FAILED]_ #
[FAIL] 29 selftests bpf test_libbpf.sh
selftests: bpf_test_libbpf.sh [FAIL]

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190619/testrun/781777/log

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/bpf_test_libbpf.sh

Good linux -next tag: next-20190617
Bad linux -next tag: next-20190618
git branch     master
git commit    1c6b40509daf5190b1fd2c758649f7df1da4827b
git repo
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Best regards
Naresh Kamboju
