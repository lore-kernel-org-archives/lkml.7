Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76192C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D1C206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfC0TYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:24:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731942AbfC0TYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:24:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RJJNe9074947
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:24:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgd5ewkhe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:24:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Mar 2019 19:24:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 19:23:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RJNvaA29163564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 19:23:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F23C11C05E;
        Wed, 27 Mar 2019 19:23:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C782D11C04C;
        Wed, 27 Mar 2019 19:23:55 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 19:23:55 +0000 (GMT)
Subject: Re: [PATCH 2/2 v2] efi: print appropriate status message when
 loading certificates
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Date:   Wed, 27 Mar 2019 15:23:55 -0400
In-Reply-To: <20190324002621.3551-2-jlee@suse.com>
References: <20190324002621.3551-1-jlee@suse.com>
         <20190324002621.3551-2-jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032719-0028-0000-0000-00000359055A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032719-0029-0000-0000-00002417C2CE
Message-Id: <1553714635.4608.34.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-24 at 08:26 +0800, Lee, Chun-Yi wrote:
> When loading certificates list from UEFI variable, the original error
> message direct shows the efi status code from UEFI firmware. It looks
> ugly:
> 
> [    2.335031] Couldn't get size: 0x800000000000000e
> [    2.335032] Couldn't get UEFI MokListRT
> [    2.339985] Couldn't get size: 0x800000000000000e
> [    2.339987] Couldn't get UEFI dbx list
> 
> So, this patch shows the status string instead of status code.
> 
> On the other hand, the "Couldn't get UEFI" message doesn't need
> to be exposed when db/dbx/mok variable do not exist. So, this
> patch set the message level to debug.
> 
> v2.
> Setting the MODSIGN messagse level to debug.
> 
> Link: https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
> Cc: James Morris <jmorris@namei.org>
> Cc: Serge E. Hallyn" <serge@hallyn.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Josh Boyer <jwboyer@fedoraproject.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  security/integrity/platform_certs/load_uefi.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 81b19c52832b..e65244b31f04 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -48,7 +48,9 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>  
>  	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
>  	if (status != EFI_BUFFER_TOO_SMALL) {
> -		pr_err("Couldn't get size: 0x%lx\n", status);
> +		if (status != EFI_NOT_FOUND)
> +			pr_err("Couldn't get size: %s\n",
> +				efi_status_to_str(status));
>  		return NULL;
>  	}
>  
> @@ -59,7 +61,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>  	status = efi.get_variable(name, guid, NULL, &lsize, db);
>  	if (status != EFI_SUCCESS) {
>  		kfree(db);
> -		pr_err("Error reading db var: 0x%lx\n", status);
> +		pr_err("Error reading db var: %s\n",
> +			efi_status_to_str(status));
>  		return NULL;
>  	}
>  
> @@ -155,7 +158,7 @@ static int __init load_uefi_certs(void)
>  	if (!uefi_check_ignore_db()) {
>  		db = get_cert_list(L"db", &secure_var, &dbsize);
>  		if (!db) {
> -			pr_err("MODSIGN: Couldn't get UEFI db list\n");
> +			pr_debug("MODSIGN: Couldn't get UEFI db list\n");

Sure, this is fine.

>  		} else {
>  			rc = parse_efi_signature_list("UEFI:db",
>  					db, dbsize, get_handler_for_db);
> @@ -168,7 +171,7 @@ static int __init load_uefi_certs(void)
>  
>  	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
>  	if (!mok) {
> -		pr_info("Couldn't get UEFI MokListRT\n");
> +		pr_debug("Couldn't get UEFI MokListRT\n");

This is fine too.

>  	} else {
>  		rc = parse_efi_signature_list("UEFI:MokListRT",
>  					      mok, moksize, get_handler_for_db);
> @@ -179,7 +182,7 @@ static int __init load_uefi_certs(void)
>  
>  	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
>  	if (!dbx) {
> -		pr_info("Couldn't get UEFI dbx list\n");
> +		pr_debug("Couldn't get UEFI dbx list\n");

If there isn't a db or moklist, then this is fine.  My concern is not
having an indication that the dbx wasn't installed, when it should
have been.

Perhaps similar to the "Loading compiled-in X.509 certificates"
informational message there should informational messages for db, mok,
and dbx as well.

Mimi


>  	} else {
>  		rc = parse_efi_signature_list("UEFI:dbx",
>  					      dbx, dbxsize,

