Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C108DC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E21221670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="uG007aD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfGIQXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:23:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36912 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:23:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so7039151plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HkoWtg3+2XTaihhdsMNcreTYV2cAjEr9DuG3PQom/00=;
        b=uG007aD2XHi8AYGVtR5ZtT6AvkrDdMso70i2MYzVGdfgxstJdVzNN6blo72WVlUzX0
         cogsnCOg/lhe4nEO+FoD8NXk3UdMbdVmFFZCQ/QC7+i8lByTieCporZYLRbl0Nd1w2/C
         6BWEDdwk2n13bnHqgpIUNd4UBAxtdsjzWuSZKCJpYY6w8bOfcLJZzs7COrsQA9B+iuO2
         qOtk8XkHargG9L4ESTllKu0UdcvkfACDlyMDxiq9l19jl6/BQqskGvZKaKst6X4KShpr
         4EHdwLZgEE17yAaTvI0bczvgaoLHcSH7SEjkEFdKtQkb+DUV40C1jDaCxxpcEXKGlLvL
         5xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HkoWtg3+2XTaihhdsMNcreTYV2cAjEr9DuG3PQom/00=;
        b=WPYmeBZUvDC2GcPemw0nRGf+9VHKhHDxpFbnD3V/0X5gtQUduWeNvSFfiPqyER9e5f
         IEMPf0X3uOygjvohNnTbTCR3ApGitxGALrSl6buWBBeWoJ91iey6xjoaVOIZtrIFGUy/
         CrDGjXixU7JJRJpBWoqeuw7/pa4F7pngcmj1wSBFS/EttfHcc4H5rzPLRXpcf2APQ6Fb
         ohH2Dq7zQdamizO9h5V7anLvKnHjinr05tDVBPcc+FUlHIzphSZR25xn75nrBT6miahB
         0MJCRsX2xHKNDCAeATKaJF7P2HshYWD4fJ2/UWMk71AViolcMlcs9yI4Pe9kkiUA3WxW
         tmPw==
X-Gm-Message-State: APjAAAVlFZ1gvy7eSSq4rYrtNP4SW3ew+W8q1Z1QUdKxNyLaaZDQrzjx
        9e4P02cggusZ7BejHyXRi/eAuw==
X-Google-Smtp-Source: APXvYqxPVsH0B4sX4aoOMXTb/bJpSpmYHY/aTTZfGE9/0NZNSxWNOp9TOZ1abUHua2rHLwtHvWmuKw==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7mr33662980plq.288.1562689397856;
        Tue, 09 Jul 2019 09:23:17 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([100.96.59.204])
        by smtp.googlemail.com with ESMTPSA id w18sm27242499pfj.37.2019.07.09.09.23.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 09:23:17 -0700 (PDT)
To:     linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Miklos Szeredi <miklos@szeredi.hu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-team@android.com
From:   Mark Salyzyn <salyzyn@android.com>
Subject: RFC: BUG: overlayfs getxattr recursion leaves a poison sid.
Message-ID: <b5c3bc4a-eb39-d994-7723-947a464383a2@android.com>
Date:   Tue, 9 Jul 2019 09:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For EACCES return for getxattr, sid appears to be expected updated in 
parent node. For some accesses purely cosmetic for correct avc logging, 
and depending on kernel vintage for others (older than 4.4) the lack of 
the corrected sid in the parent overlay inode poisons the security cache 
and results in false denials.

The avc denials would contain an (incorrect) unlabelled target 
references, we could fix this by copying up the sid to the parent inode. 
However the test (below) needs to refactored to the pleasure of the 
security, selinux and overlayfs maintainers. The security_socket_accept 
function is _close_, it will copy sid and class from the old socket to 
the new. Along those lines, we probably need to add a new 
security_copy_to_upper handler that takes the upper and lower dentries 
and ensures that the upper contains all the security information 
associated with the lower.

Prototype adjustment (tested in 3.18 to ToT)

int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char 
*name, { ssize_t res; const struct cred *old_cred; struct dentry 
*realdentry = ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry); 
old_cred = ovl_override_creds(dentry->d_sb); res = 
vfs_getxattr(realdentry, name, value, size); ovl_revert_creds(old_cred); 
+ if (res == -EACCES) { + selinux_copy_sid(dentry, realdentry); return 
res; }

. . .

+ void selinux_copy_sid(struct dentry *parent, struct dentry *child) + { 
+ struct inode *pinode, *cinode; + struct inode_security_struct *pisec, 
*cisec; + + if (!parent || !child) + return; + pinode = parent->d_inode; 
+ cinode = child->d_inode; + if (!pinode || !cinode) + return; + pisec = 
pinode->i_security; + cisec = cinode->i_security; + if (!pisec || 
!cisec) + return; + pisec->sid = cisec->sid; + } + 
EXPORT_SYMBOL_GPL(selinux_copy_sid);

Sincerely -- Mark Salyzyn

