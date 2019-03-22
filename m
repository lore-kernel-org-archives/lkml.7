Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD50C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8C2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=binghamton.edu header.i=@binghamton.edu header.b="VH322g9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfCVIfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:35:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33840 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:35:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so1642892qtm.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=binghamton.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+5vHzaM94PHzv+dji4AwOBZn3vkWoXUaRBYZUH01I8=;
        b=VH322g9hoUB26uiYPCGItW0jJWpi8Vr400pYKeYX67/VlRiiu9FTkUL+3DJgBOHk3J
         RgjCf6yFqx7OMlsut5RFvOQZF0mtaPcFFFJYJbJnJDSDsiCJT+G7r8t4gM1FTHotxpgk
         7itB5rNapVkAbxxjxptcL1pwwzLO1UgP6FUo2EbTf2HbrwGXhqDKA3aj2FlRo3BiHa9R
         IcCqpoKjYXOpk2W8vYUuBnf4o+1OWaBWiFdCXlmTEmbu3shQ57OYYp5Pleyk2DJDTq0Y
         VDCTGXAvbf8p4C/dnn7hlvXNKubf6Yk1vH4mdBAf0hYeWFVUUCV+FKhhWJjZQlXdw7bg
         YZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+5vHzaM94PHzv+dji4AwOBZn3vkWoXUaRBYZUH01I8=;
        b=ediIDVktnWkCxw60iDSog+Xgu8TMf39yrqgD7OHP32lbuYyk60bnBPorRuxymAgwP2
         Il+LnRQhx3b+3dcXUZ00vzkxz90RCi6kRiPeFkYp8aAfCTPPVv37gYpmArMlDnzXkkpl
         ogQg8GOLfToaRSIdhdWH9gfJiZHv8uyk62qWDTT1s1qslDj3eoV49lRbwojJJO18Klf+
         WSBPBtnywzbB3kD//wUWOKyta2h1t5SZPTZFnDT1dPkhA54LNuAty2lScl/0YCt+rpr/
         VmLZIwWsgLtEW99RLnNf5AQXR+iD5GxBEx/4sDJwjeKZi+1ShM5tTgg4LNx5lgaR7n88
         KSaQ==
X-Gm-Message-State: APjAAAW7ktNXHudgG8WI41dQr1y/vAF+Xt5kAHFZJOeVo4837XR4KW0S
        N45PMwnO1cukdc8GRIgyFCMZdw==
X-Google-Smtp-Source: APXvYqyqkGGC3LzyX2zgNQm+6lL4OrrKQVIKEeFukf3jJwF9HhQXjH0xLwPCcoyIUIXY4z8DB1zi4Q==
X-Received: by 2002:ac8:2eb8:: with SMTP id h53mr6742069qta.188.1553243704023;
        Fri, 22 Mar 2019 01:35:04 -0700 (PDT)
Received: from localhost.localdomain ([194.59.251.45])
        by smtp.gmail.com with ESMTPSA id u16sm7441870qtc.84.2019.03.22.01.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 01:35:03 -0700 (PDT)
From:   djacobs7@binghamton.edu
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, pvorel@suse.cz, vt@altlinux.org,
        David Jacobson <djacobs7@binghamton.edu>
Subject: [PATCH v2 5/8] evmtest: validate boot record
Date:   Fri, 22 Mar 2019 04:34:38 -0400
Message-Id: <20190322083441.31084-5-djacobs7@binghamton.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322083441.31084-1-djacobs7@binghamton.edu>
References: <20190322083441.31084-1-djacobs7@binghamton.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jacobson <djacobs7@binghamton.edu>

The first record in the IMA runtime measurement list is the boot
aggregate - a hash of PCRs 0-7. This test calculates the boot aggregate
based off the PCRs and compares it to IMA's boot aggregate.

Dependencies: a TPM, IBMTSS2.

Signed-off-by: David Jacobson <djacobs7@binghamton.edu>

Changelog:
* Added boot_aggregate to test list
* shellcheck compliant
* minor fixes
* move from functions to tests
* redid tss parsing
* checkbashisms complaint
* remove begin
* removed long opts
* restructured to use functions
* added changes from Mimi to work with new TSS
* removed searching for TSS locations
---
 evmtest/README                  |   1 +
 evmtest/evmtest                 |   1 +
 evmtest/tests/boot_aggregate.sh | 140 ++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100755 evmtest/tests/boot_aggregate.sh

diff --git a/evmtest/README b/evmtest/README
index 91c8cda..b2d37e2 100644
--- a/evmtest/README
+++ b/evmtest/README
@@ -36,6 +36,7 @@ OPTIONS
 TEST NAMES
 ----------
 
+ boot_aggregate - verify the IMA boot-aggregate
  env_validate - verify kernel build
  example_test - example test
  policy_sig - verify loading IMA policies
diff --git a/evmtest/evmtest b/evmtest/evmtest
index cd5e238..3c967f9 100755
--- a/evmtest/evmtest
+++ b/evmtest/evmtest
@@ -26,6 +26,7 @@ usage (){
 	# Any test should be added here manually
 	# The reason this is manual is to prevent the accidental / malicious
 	# placement of a script in tests/
+	echo "[R]	boot_aggregate"
 	echo "[R]	env_validate"
 	echo "[ ]	examples_test"
 	echo "[R]	kexec_sig"
diff --git a/evmtest/tests/boot_aggregate.sh b/evmtest/tests/boot_aggregate.sh
new file mode 100755
index 0000000..adecfeb
--- /dev/null
+++ b/evmtest/tests/boot_aggregate.sh
@@ -0,0 +1,140 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="boot_aggregate"
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source "$ROOT"/files/common.sh
+
+VERBOSE=0
+TPM_VERSION="2.0"
+# This test validates the eventlog against the hardware PCRs in the TPM, and
+# the boot aggregate against IMA.
+
+usage (){
+	echo "boot_aggregate [-hv]"
+	echo ""
+	echo "	This test must be run as root"
+	echo ""
+	echo "	This test validates PCRs 0-7 in the TPM"
+	echo "	It also validates the boot_aggregate based those PCRs"
+	echo "	against what IMA has recorded"
+	echo ""
+	echo "	-h	Display this help message"
+	echo "	-v	Verbose logging"
+}
+
+parse_args () {
+	TEMP=$(getopt -o 'hv'  -n 'boot_aggregate' -- "$@")
+	eval set -- "$TEMP"
+
+	while true ; do
+		case "$1" in
+			-h) usage; exit; shift;;
+			-v) VERBOSE=1; shift;;
+			--) shift; break;;
+			*) echo "[*] Unrecognized option $1"; exit 1 ;;
+		esac
+	done
+}
+
+check_requirements () {
+	v_out "Checking if securityfs is mounted..."
+	if [ -z "$EVMTEST_SECFS_EXISTS" ]; then
+		fail "securityfs not found..."
+	fi
+
+	v_out "Verifying TPM is present..."
+	if [ ! -d "$EVMTEST_SECFS/tpm0" ]; then
+		fail "Could not locate TPM in $EVMTEST_SECFS"
+	fi
+
+	v_out "TPM found..."
+
+	v_out "Checking if system supports reading event log..."
+
+	if [ ! -f "$EVMTEST_SECFS"/tpm0/binary_bios_measurements ]; then
+			fail "Kernel does not support reading BIOS measurements,
+			please update to at least 4.16.0"
+	fi
+
+	v_out "Verifying TPM Version"
+	if [ -e /sys/class/tpm/tpm0/device/caps ]; then
+		TPM_VERSION="1.2"
+	fi
+}
+
+check_pcrs () {
+	v_out "Grabbing PCR values..."
+	local pcrs=() # array to store the Hardware PCR values
+	local sim_pcrs=() # What PCRs should be according to the event log
+	local eventextend=tsseventextend
+	local pcrread="tsspcrread -halg sha1"
+	local eventlog=/sys/kernel/security/tpm0/binary_bios_measurements
+
+	if [ "$TPM_VERSION" == "1.2" ]; then
+		eventextend=tss1eventextend
+		pcrread=tss1pcrread
+	fi
+
+	for ((i=0; i<=7; i++)); do
+		pcrs[i]=$(TPM_INTERFACE_TYPE=dev $pcrread -ha "$i" -ns)
+	done
+
+	local output=$(mktemp -u)
+	"$eventextend" -if "$eventlog" -sim -ns > "$output"
+
+	# Some PTT's are using TPM 1.2 event log format.  Retry on failure.
+	if [ $? -ne 0 ]; then
+		eventextend=tss1eventextend
+		"$eventextend" -if "$eventlog" -sim -ns > "$output"
+	fi
+
+	IFS=$'\n' read -d '' -r -a lines < "$output"
+	rm "$output"
+
+	for line in "${lines[@]}"
+		do
+		:
+		sim_pcrs+=( "$(echo "$line" | cut -d ':' -f2 | \
+				tr -d '[:space:]')" )
+		if printf '%s' "$line" | grep -E -q "boot aggregate"; then
+			tss_agg=$(echo "$line" | cut -d ':' -f2 | \
+				tr -d '[:space:]')
+		fi
+	done
+
+	v_out "Validating PCRs.."
+	for ((i=0; i<=7; i++)); do
+		v_out "SIM PCR [$i]: ${sim_pcrs[$i]}"
+		v_out "TPM PCR [$i]: ${pcrs[$i]}"
+		if [  "${pcrs[$i]}" != "${sim_pcrs[$i]}" ]; then
+			v_out "PCRs are incorrect..."
+			fail "Mismatch at PCR $i "
+		else
+			v_out "PCR $i validated..."
+		fi
+	done
+}
+
+check_boot_aggregate () {
+	v_out "Validating Boot Aggregate..."
+	ima_agg=$(grep boot_aggregate \
+	"$EVMTEST_SECFS"/ima/ascii_runtime_measurements| head -1 | cut \
+		-d ":" -f2|cut -d " " -f1)
+	v_out "TSS BOOT AGG: $tss_agg"
+	v_out "IMA BOOT AGG: $ima_agg"
+
+	if [ "$tss_agg" != "$ima_agg" ]; then
+		fail "Boot Aggregate is inconsistent"
+	else
+		v_out "Boot Aggregate validated"
+	fi
+}
+
+EVMTEST_require_root
+echo "[*] Starting test: $TEST"
+parse_args "$@"
+check_requirements
+check_pcrs
+check_boot_aggregate
+passed
-- 
2.20.1

