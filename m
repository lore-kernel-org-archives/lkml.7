Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA34CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1C021906
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPSBMj5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfJUQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:16:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33965 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:16:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so9552711wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2LUAEHBA+y/RJCuqLYg7TE/fmTT0Gl4J+UG5fDkDk8=;
        b=aPSBMj5U2GkS0CtIXWn74VZb6yffXEgx3z6winBzWnBDNQ53i/f7bD9KqMaPrY/bMX
         oc7TpTbiTRXAg7/8NDaXg30t7vfmCgUEB14qCc54yb9MGPXl7NDoGWsaEz2IDbUMGTe/
         3oGif4tqXp4UxbtWM6VelgPy7EQMFZiGPzi5TSxtNSL0OS4iJlsN7Va84+JdhaJIOiPL
         WToxyYEgokmDfwbs2lUHRjMA2+skkg2tDQ75kvf8V21l4QeIpW3/bt4kdL7wIIEfFWv3
         hRQT5hwouoWaW/6096t3Oq0SExdae+esdSFm6qVBt6TAws81aHCUcBshXdYmTfvlnnno
         wIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2LUAEHBA+y/RJCuqLYg7TE/fmTT0Gl4J+UG5fDkDk8=;
        b=I3urR4jeNSIjen/ZqivTeCy/axqtA26MCcL7mQ77vdfEEH+yxEgFIvoc3MCrH3wK/0
         IKdfzQTroC4+yV67T+mX6+KWFeG6AQR7hHAobQFsrzGfqoikr2ixs6EcTDjY/cfrfuwe
         rG++61gO0Ss1x4PC17msZuBUCwvOOML5gYXyj9560/m94tJ0679hX10QhQYqwaAnJwIb
         pT79eh6RIzHOuAIrNgd3Fk5T4YKVspRkfcuafeQ5eZK9f8mv5uGJ9NCROh9gzG6d2Dzs
         vxnpEgLSnpNwnxz68zONgZ84rtOgOZ8sV7HcXDL8aYE6qd+YNulGzeeT06h2V+aaHnRw
         5K7g==
X-Gm-Message-State: APjAAAV1CvY5AcRBZyoGD67dtVrfsos5AS8syV6iU2Ju6lINrQVMK1OP
        duXryZokGZltafUbwzBnDGYgRg==
X-Google-Smtp-Source: APXvYqzGV2r6ibkgS5v+c4aTMqcvcaQ6bndOoDtPdoVGjt9vf2C7lwE1ROPULRraYKx7au/inwaJ9Q==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr18448414wrl.140.1571674601847;
        Mon, 21 Oct 2019 09:16:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id p12sm15907599wrm.62.2019.10.21.09.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:16:41 -0700 (PDT)
Date:   Mon, 21 Oct 2019 17:16:40 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] scripts/nsdeps: use alternative sed delimiter
Message-ID: <20191021161640.GA68110@google.com>
References: <20191021145137.31672-1-jeyu@kernel.org>
 <20191021160419.28270-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191021160419.28270-1-jeyu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica!

On Mon, Oct 21, 2019 at 06:04:19PM +0200, Jessica Yu wrote:
>When doing an out of tree build with O=, the nsdeps script constructs
>the absolute pathname of the module source file so that it can insert
>MODULE_IMPORT_NS statements in the right place. However, ${srctree}
>contains an unescaped path to the source tree, which, when used in a sed
>substitution, makes sed complain:
>
>++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
>sed: -e expression #1, char 12: unknown option to `s'
>
>The sed substitution command 's' ends prematurely with the forward
>slashes in the pathname, and sed errors out when it encounters the 'h',
>which is an invalid sed substitution option. To avoid escaping forward
>slashes in ${srctree}, we can use '|' as an alternative delimiter for
>sed to avoid this error.
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>---

Thanks for fixing this. I tested O=, but not with a truly out of tree
build and got outsmarted by ${srctree} being '..' for O=subdir/.

Reviewed-by: Matthias Maennich <maennich@google.com>
Tested-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>
>This is an alternative to my first patch here:
>
>  http://lore.kernel.org/r/20191021145137.31672-1-jeyu@kernel.org
>
>Matthias suggested using an alternative sed delimiter instead to avoid the
>ugly/unreadable ${srctree//\//\\\/} substitution.
>
> scripts/nsdeps | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/scripts/nsdeps b/scripts/nsdeps
>index 3754dac13b31..63da30a33422 100644
>--- a/scripts/nsdeps
>+++ b/scripts/nsdeps
>@@ -33,7 +33,7 @@ generate_deps() {
> 	if [ ! -f "$ns_deps_file" ]; then return; fi
> 	local mod_source_files=`cat $mod_file | sed -n 1p                      \
> 					      | sed -e 's/\.o/\.c/g'           \
>-					      | sed "s/[^ ]* */${srctree}\/&/g"`
>+					      | sed "s|[^ ]* *|${srctree}\/&|g"`
> 	for ns in `cat $ns_deps_file`; do
> 		echo "Adding namespace $ns to module $mod_name (if needed)."
> 		generate_deps_for_ns $ns $mod_source_files
>-- 
>2.16.4
>
