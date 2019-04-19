Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26923C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863D217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKYEkw68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfDSU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:27:58 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46909 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:27:58 -0400
Received: by mail-pl1-f175.google.com with SMTP id o7so799483pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=8JkLXzmPOqLtZX8yX9rlnRg79Wg8uW1qURcd86gjSYM=;
        b=nKYEkw68/rlpYgZYwd1IuVc0TyyWzSaEYcFhinuav2f/Okpypscx2o+ctujhT5Qj23
         WPI8so2VD4TMO3XE6zbMCMQwiCEDN0W7eoQBfCtCnPd3/N1Gvev/MBQso2H5koJTNJkC
         Bq7yoUAMqzoxb9E3KpRmcYiQodrqqM9nirmcNDp3eWRZFv4lubOPCL9CfX8ZabXh/Ftd
         hGHBWXfgPM7GGiS/1ye8C0UwB52zEF1xPr+KUKE4/mpYphKgTvDQbnTZpBbIJFNiuU4/
         BdYZYcESf/TjLE2QIdy90Am0LoW49EXTFDJHpqLwwbEpnvd/2EfkSv9+Bg1GJ0QMv6GK
         onbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=8JkLXzmPOqLtZX8yX9rlnRg79Wg8uW1qURcd86gjSYM=;
        b=nLHdPPE64dn0L8Qo3ipnoT1NJ+aGSvOWFMNKRgtpd4kuTh/YNMfMF6+eBbLCdTgDOQ
         5OcE5WiJkn4sbnvmcoqYmcyWIUtDLRnJMGdvY2lUG/sWLIaHyy87WbVKsJXsmN5Sn1ue
         RjZk6Fgu2nRDu3VcLC+tZFjl1/7LoxgXvkB+OJ9czq6AXuAup98mKCkbQ+PT2ayilTu0
         mIXAmr+HcOZfAipipL9XkIJFjqo4xtEYG156YWB5sC1JRU6V1rcU6snCLq+zTaUjKC/a
         sbjE6hcS1FtvzdsjEoFcBcAKXZxwTvqlOympIKW9n3rSNmPf6i2L1a7xEa5abCBkues/
         fjCA==
X-Gm-Message-State: APjAAAUiEsJnM/VBsTMDsX+vfMwEaZn5Oue0i6ZVHcbFhELj9hSscMQY
        wdISjLEC7J2gYt/lSr/Hx2OfyrLE
X-Google-Smtp-Source: APXvYqwgXIO/irQw/yARQpCl+MPPhGR4EiRhUy9rXYrtymKlj9ftLZsxEGn7vU+6Jrj+s2vJbTlDsQ==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr2495565plp.294.1555662823056;
        Fri, 19 Apr 2019 01:33:43 -0700 (PDT)
Received: from localhost ([175.223.3.190])
        by smtp.gmail.com with ESMTPSA id d129sm7248621pfa.142.2019.04.19.01.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 01:33:42 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:33:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [next] kbuild: use $(srctree) instead of KBUILD_SRC to check
 out-of-tree build
Message-ID: <20190419083339.GA8504@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,

It seems that commit a9a49c2ad9b9b8 (linux-next) breaks ./scripts/tags.sh
on my system. It scans, basically, my entire drive now (including the
root partition):

$ ./scripts/tags.sh tags
find: ‘/arch/*.[chS]/’: No such file or directory
find: ‘/include’: No such file or directory
find: ‘/boot/lost+found’: Permission denied
find: ‘/etc/pacman.d/gnupg/openpgp-revocs.d’: Permission denied
find: ‘/etc/pacman.d/gnupg/private-keys-v1.d’: Permission denied
find: ‘/etc/pacman.d/gnupg/crls.d’: Permission denied
find: ‘/etc/polkit-1/rules.d’: Permission denied
find: ‘/etc/sudoers.d’: Permission denied
find: ‘/etc/audisp/plugins.d’: Permission denied
find: ‘/home/lost+found’: Permission denied
find: ‘/home/sk’: Permission denied
find: ‘/lost+found’: Permission denied
ctags: Warning: --extra option is obsolete; use --extras instead
[..]


With reverted a9a49c2ad9b9b8 tags scans kernel source tree only

./scripts/tags.sh tags
find: ‘arch/*.[chS]/’: No such file or directory
ctags: Warning: --extra option is obsolete; use --extras instead
[..]

	-ss
