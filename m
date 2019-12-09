Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D8C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C320721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fsQIqClh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfLIX4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:56:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47081 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfLIX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:56:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so11343872lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 15:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLqN4/IUc9R1B2G8hkahDuDsKQb+tqVkqB0eS8GumWY=;
        b=fsQIqClh8cCQwVMNi64O+uLYyJYb9A7DfVz26EeOCRhVUT0WiKRxceewQtOXxZ3v6c
         ODOYHxGBGTXd18P8p/Sv6AQzFHGYbF6ATH0rduJGhrTB1euZILfbusANQJGQMW1oqImh
         DYH8aCUnIFql12mLdSKoiqaadwpJKYTt7x3ozEfBih1h+QPv4BNK65HLpLAN3sYIC43H
         lfoRrV4w8hgCBHsRNYNGp2g6CS5KviHOFxQhD1EMZVJl7ljxC4VTfGxfpdXCUmM2E/pe
         3SwdU4zOGCKO/pTcThlLtqKRTB8AKQayTzGKzeCp8ZVNFYNJOLr09jKH/Km1Ay6Nlb1t
         psog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLqN4/IUc9R1B2G8hkahDuDsKQb+tqVkqB0eS8GumWY=;
        b=DGCFjxA/mshTSr8vg/KcoWxjClrUG95blwcnn0aHymQDjjTQgQYnQOY4eIZadCncLa
         krySfrdW5I/XtDrWbDm5pMAZa1+gMS0Ia4/xBiN7tez5F8HI8KkMaPNHwnZuj2MbxSRB
         Cvko37CdHL0/eA7Xq7vdEOjOPWfOsME2nihrknrTmHk6+x8NB1PJP6ZUH0VF26ZP1bJv
         +0c1eY/LpF44HEbl2KSten0T7QnO9IiOzGIfcOUU7xsIGeVGH6U2vROakCJt56JbQxLC
         8onNbWdld1Qj432E09gO1SKY1PiZ4I3UcCK3IDI+lSLqo+J6ubMN701lVGZTxVaR40g5
         sOYw==
X-Gm-Message-State: APjAAAWD5pgAryMVPlhOHFBTAL0A57Bkd1z3zJgQdD1ftbOgoH9HfrEM
        tjdobHEh/rwmqUMA+cuE4JU7wQ0+zaAwzHFRth+6kjM=
X-Google-Smtp-Source: APXvYqyW3brFpY8T+Vh5W3sZI4v9w5DtieT95776Q0vWz2BO0M2OwI0v8jhAWm9vMQd7hLQKjZv3OjZB914IaZuX/vo=
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr16602770lfk.175.1575935770341;
 Mon, 09 Dec 2019 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20191210105037.085b3418@canb.auug.org.au>
In-Reply-To: <20191210105037.085b3418@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 18:55:59 -0500
Message-ID: <CAHC9VhRnyCuV-w-irXdC_WL_aF92Brs1UhN9iuTaqCKHamA+gg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the keys tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jamorris@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 6:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   include/linux/lsm_audit.h
>
> between commit:
>
>   59336b0f8000 ("smack: Implement the watch_key and post_notification hooks")
>
> from the keys tree and commit:
>
>   59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
>
> from the selinux tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc include/linux/lsm_audit.h
> index 734d67889826,99d629fd9944..000000000000
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@@ -74,7 -74,7 +74,8 @@@ struct common_audit_data
>   #define LSM_AUDIT_DATA_FILE   12
>   #define LSM_AUDIT_DATA_IBPKEY 13
>   #define LSM_AUDIT_DATA_IBENDPORT 14
>  -#define LSM_AUDIT_DATA_LOCKDOWN 15
>  +#define LSM_AUDIT_DATA_NOTIFICATION 15
> ++#define LSM_AUDIT_DATA_LOCKDOWN 16
>         union   {
>                 struct path path;
>                 struct dentry *dentry;

That should be fine, thanks.

-- 
paul moore
www.paul-moore.com
