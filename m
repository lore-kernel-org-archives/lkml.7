Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDE6C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6DB21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="pZp1kUM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGIQlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:41:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41041 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfGIQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:41:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so9562135pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=LjCqOPogmaN342Ext4GkWHH7a8C0WeqklVniarDPpUQ=;
        b=pZp1kUM1IpBtx23qfXg8T+jMMw6RmniKpoxETZMZmt9B43XtwgrD9NAmIxH2WzFDuu
         uxmMIpnxnZcguYO+lbNGcQOOXCdELn0+ZZoDjbxkqKVZgICinCSwVA0eqjJAtn5HtCvi
         clWItP5CbqmDlBPMvxKVltxMMLQVShEna4/VyPNeA3L9meyrOMJ7jS7e9gYDiG+Yt1RW
         NMReZLzVkD0l1IWosA+LxbJUjQZuFe52VHcVoXQcG5y+wRVRxUhaGfWdiAIhLhVWgEKI
         QBNxQCyOWmLylbpDmHk5q77Df/cOUhA2EPKjfq7LWbYHSIvYiXqd7fuk1GAWSoAANEJk
         i49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LjCqOPogmaN342Ext4GkWHH7a8C0WeqklVniarDPpUQ=;
        b=oStB/aRCaLJFyeu0kS4d2ytK0fa8bGXfooKnMVxQyf7xLnEU75pOvzACrv5jCZKPgg
         BUMEz/3WzB/nZMjQ5xk4606ohabYKgUenejIYYj+Tg3SePXbTWPKPHOF+zpg7Zi0mMyb
         ITBTUPH+m/mQRHR7qFZWmGAvohryF4noyJ+jN1jI9O45Bj0zKAzu1VmdkmZvcAjYUYGk
         OyJz59JBRcAf5psDveOCNuhKI45cxbMBTlDebpoc9jBgYO8xjhWMOCfsGRDs9oHfbCnd
         Apw/ukBxUEF1s/jWxBE/z9Qux98DY9vflB3tgvooiAvGhg9x3ul2rI7lZYuhRr3uv3Tj
         rhVQ==
X-Gm-Message-State: APjAAAWrznUIGu+Cc26I97FT+/zHQ32Tixd1zPsJ3uXjHQUbhbz/em3D
        vUmyml90s2eCEkiJVk7r6AQFtQ==
X-Google-Smtp-Source: APXvYqz9+gzr4jJf1bq2FZfW3SD3587F40aPFcC2v62N7K2zYg/3Di7RqjWW3G4sE7etfJh72C89+A==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr31401796pgc.139.1562690483019;
        Tue, 09 Jul 2019 09:41:23 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([100.96.59.204])
        by smtp.googlemail.com with ESMTPSA id l124sm32360162pgl.54.2019.07.09.09.41.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 09:41:22 -0700 (PDT)
Subject: Re: RFC: BUG: overlayfs getxattr recursion leaves a poison sid.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Miklos Szeredi <miklos@szeredi.hu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-team@android.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <b5c3bc4a-eb39-d994-7723-947a464383a2@android.com>
 <7b6eb68e-44ae-5df8-9ebd-d334fc134938@schaufler-ca.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <54a934de-2e1b-c09e-2e06-be8e56144f84@android.com>
Date:   Tue, 9 Jul 2019 09:41:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7b6eb68e-44ae-5df8-9ebd-d334fc134938@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 9:33 AM, Casey Schaufler wrote:
> On 7/9/2019 9:23 AM, Mark Salyzyn wrote:
>> For EACCES return for getxattr, sid appears to be expected updated in parent node. For some accesses purely cosmetic for correct avc logging, and depending on kernel vintage for others (older than 4.4) the lack of the corrected sid in the parent overlay inode poisons the security cache and results in false denials.
>>
>> The avc denials would contain an (incorrect) unlabelled target references, we could fix this by copying up the sid to the parent inode. However the test (below) needs to refactored to the pleasure of the security, selinux and overlayfs maintainers. The security_socket_accept function is _close_, it will copy sid and class from the old socket to the new. Along those lines, we probably need to add a new security_copy_to_upper handler that takes the upper and lower dentries and ensures that the upper contains all the security information associated with the lower.
> Please include the LSM (CCed) list on all LSM impacting discussions.
> Your mailer mangled the patch. Please resend in plain text.
>
> Thank you.
>
>> Prototype adjustment (tested in 3.18 to ToT)
(annoyed that Thunderbird let me down even after selecting text plain text)

  int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const 
char *name,
  {
      ssize_t res;
      const struct cred *old_cred;
      struct dentry *realdentry =
          ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);

      old_cred = ovl_override_creds(dentry->d_sb);
      res = vfs_getxattr(realdentry, name, value, size);
      ovl_revert_creds(old_cred);
+    if (res == -EACCES)
+        selinux_copy_sid(dentry, realdentry);
      return res;

  }

. . .
+ void selinux_copy_sid(struct dentry *parent, struct dentry *child)
+ {
+     struct inode *pinode, *cinode;
+     struct inode_security_struct *pisec, *cisec;
+
+     if (!parent || !child)
+         return;
+     pinode = parent->d_inode;
+     cinode = child->d_inode;
+     if (!pinode || !cinode)
+         return;
+     pisec = pinode->i_security;
+     cisec = cinode->i_security;
+     if (!pisec || !cisec)
+         return;
+     pisec->sid = cisec->sid;
+ }
+ EXPORT_SYMBOL_GPL(selinux_copy_sid);


