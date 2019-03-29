Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B16C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07E8218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfC2Rkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:40:53 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39879 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfC2Rkw (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 29 Mar 2019 13:40:52 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 29 Mar 2019 18:40:50 +0100
Received: from localhost (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Fri, 29 Mar 2019 17:40:35 +0000
Date:   Sat, 30 Mar 2019 01:40:26 +0800
From:   jlee@suse.com
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] efi: print appropriate status message when
 loading certificates
Message-ID: <20190329174026.GB3701@localhost>
References: <20190324002621.3551-1-jlee@suse.com>
 <20190324002621.3551-2-jlee@suse.com>
 <1553714635.4608.34.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553714635.4608.34.camel@linux.ibm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 03:23:55PM -0400, Mimi Zohar wrote:
> On Sun, 2019-03-24 at 08:26 +0800, Lee, Chun-Yi wrote:
> > When loading certificates list from UEFI variable, the original error
> > message direct shows the efi status code from UEFI firmware. It looks
> > ugly:
> > 
> > [    2.335031] Couldn't get size: 0x800000000000000e
> > [    2.335032] Couldn't get UEFI MokListRT
> > [    2.339985] Couldn't get size: 0x800000000000000e
> > [    2.339987] Couldn't get UEFI dbx list
> > 
> > So, this patch shows the status string instead of status code.
> > 
> > On the other hand, the "Couldn't get UEFI" message doesn't need
> > to be exposed when db/dbx/mok variable do not exist. So, this
> > patch set the message level to debug.
> > 
> > v2.
> > Setting the MODSIGN messagse level to debug.
> > 
> > Link: https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Serge E. Hallyn" <serge@hallyn.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Nayna Jain <nayna@linux.ibm.com>
> > Cc: Josh Boyer <jwboyer@fedoraproject.org>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  security/integrity/platform_certs/load_uefi.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> > index 81b19c52832b..e65244b31f04 100644
> > --- a/security/integrity/platform_certs/load_uefi.c
> > +++ b/security/integrity/platform_certs/load_uefi.c
> > @@ -48,7 +48,9 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> >  
> >  	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> >  	if (status != EFI_BUFFER_TOO_SMALL) {
> > -		pr_err("Couldn't get size: 0x%lx\n", status);
> > +		if (status != EFI_NOT_FOUND)
> > +			pr_err("Couldn't get size: %s\n",
> > +				efi_status_to_str(status));
> >  		return NULL;
> >  	}
> >  
> > @@ -59,7 +61,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> >  	status = efi.get_variable(name, guid, NULL, &lsize, db);
> >  	if (status != EFI_SUCCESS) {
> >  		kfree(db);
> > -		pr_err("Error reading db var: 0x%lx\n", status);
> > +		pr_err("Error reading db var: %s\n",
> > +			efi_status_to_str(status));
> >  		return NULL;
> >  	}
> >  
> > @@ -155,7 +158,7 @@ static int __init load_uefi_certs(void)
> >  	if (!uefi_check_ignore_db()) {
> >  		db = get_cert_list(L"db", &secure_var, &dbsize);
> >  		if (!db) {
> > -			pr_err("MODSIGN: Couldn't get UEFI db list\n");
> > +			pr_debug("MODSIGN: Couldn't get UEFI db list\n");
> 
> Sure, this is fine.
> 
> >  		} else {
> >  			rc = parse_efi_signature_list("UEFI:db",
> >  					db, dbsize, get_handler_for_db);
> > @@ -168,7 +171,7 @@ static int __init load_uefi_certs(void)
> >  
> >  	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> >  	if (!mok) {
> > -		pr_info("Couldn't get UEFI MokListRT\n");
> > +		pr_debug("Couldn't get UEFI MokListRT\n");
> 
> This is fine too.
> 
> >  	} else {
> >  		rc = parse_efi_signature_list("UEFI:MokListRT",
> >  					      mok, moksize, get_handler_for_db);
> > @@ -179,7 +182,7 @@ static int __init load_uefi_certs(void)
> >  
> >  	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> >  	if (!dbx) {
> > -		pr_info("Couldn't get UEFI dbx list\n");
> > +		pr_debug("Couldn't get UEFI dbx list\n");
> 
> If there isn't a db or moklist, then this is fine.  My concern is not
> having an indication that the dbx wasn't installed, when it should
> have been.
> 
> Perhaps similar to the "Loading compiled-in X.509 certificates"
> informational message there should informational messages for db, mok,
> and dbx as well.
>

OK. I will add message when kernel found db, dbx and mok. It will
just like the informaton message for ACPI S0,S3,S4 support.

Thanks
Joey Lee
