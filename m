Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCB6C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1485B218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfC2Xvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:51:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23305 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbfC2Xvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:51:35 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2TNp9eC025583;
        Sat, 30 Mar 2019 08:51:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sat, 30 Mar 2019 08:51:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126072090247.bbtec.net [126.72.90.247])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2TNp51Q025461
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 30 Mar 2019 08:51:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make
 oldconfig"
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190329193604.GA30908@beast>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <be269870-2dbe-6b24-d74d-a349d44b38c9@i-love.sakura.ne.jp>
Date:   Sat, 30 Mar 2019 08:51:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190329193604.GA30908@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/30 4:36, Kees Cook wrote:
> Note that since TOMOYO can be fully stacked against the other legacy
> major LSMs, when it is selected, it explicitly disables the other LSMs
> to avoid them also initializing since TOMOYO does not expect this
> currently.

Excuse me, but isn't this exception confusing, for DEFAULT_SECURITY_TOMOYO
and DEFAULT_SECURITY_DAC are "opt-in" whereas DEFAULT_SECURITY_SELINUX and
DEFAULT_SECURITY_SMACK and DEFAULT_SECURITY_APPARMOR are "opt-out" ?

If SELinux/Smack/AppArmor people think this mixture is fine, I'm fine though...

>  config LSM
>  	string "Ordered list of enabled LSMs"
> +	default "yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
> +	default "yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
> +	default "yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> +	default "yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
>  	default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
> 
